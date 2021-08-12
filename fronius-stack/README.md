# fronius-stack

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for installing fronius-exporter with long-term storage

## Installation

```bash
helm repo add ccremer https://ccremer.github.io/charts
helm install fronius-stack ccremer/fronius-stack
```
> ⚠️ **WARNING**: See [data retention](#data-retention) first!

## About

This Helm chart installs the fronius-exporter along with long-term storage and a Grafana dashboard.
The goal is to be able to do statistics of the photovoltaic installation.

I wanted to keep fronius-exporter Helm chart minimal in case you're only interested in the exporter or you're bringing your own metrics stack.

## Features

* fronius-exporter chart
* InfluxDB 2 chart
  - Post-Install hook to configure archival bucket with downsampling
* Grafana datasource
* Grafana dashboard

## Minimal required parameters

You must configure following parameters in the minimum:

```yaml
influxdb:
  adminUser:
    token: changeme
    password: changeme

fronius:
  exporter:
    symoUrl: http://your.symo.device.or.ip/solar_api/v1/GetPowerFlowRealtimeData.fcgi
  telegraf:
    influxdb:
      token: changeme # should to be the same as `influxdb.adminUser.token`!
    globalTags:
      site: my-home
```

## Data retention

Before installing the chart, think about data retention.
By default, the chart installs InfluxDB 2.0 with an initial bucket that keeps metrics for 14 days.

Additionally, the chart features a one-time post-install hook to create an archival bucket that keeps data forever.
It also creates a tasks that periodically downsamples the high-precision data to 10-minute-averages into the archival bucket.
This bucket is meant to hold data for years.

You can adjust retention with the following parameters:
```console
influxdb.adminUser.retention_policy
archival.*
```

> ℹ️ **NOTE**: After installation, any changes in bucket namings, retention or downsampling settings will NOT be applied anymore.
> You'd need to manually change this with InfluxDB CLI within the pod.

## Grafana integration

The chart comes with a Grafana datasource and dashboard ConfigMaps enabled by default.
Please ensure Grafana sidecar is enabled and it searches in the release namespace, or set `grafana.*.namespace`.

The dashboard features some panels that calculate per-day metrics.
Make sure the Fronius Symo device, InfluxDB and Grafana dashboard are roughly in the same timezone.
The Fronius Symo API includes counters like "energy per day" that reset at midnight.

## Migrating from netdata plugin

If you have used the fronius plugin that is part of netdata, you can migrate the data to the exporter variant.

As this step is done manually once, it's not automated, but here's roughly how I did it:

1. Install this chart but don't start the exporter and influxdb yet (0 replicas each).
   Also disable the archival feature for now.
2. Modify the InfluxDB 2.x StatefulSet, so that you can migrate using the Docker approach.
   You'd need to set `DOCKER_INFLUXDB_INIT_MODE=upgrade` and add the volume from the old DB.
   You can now scale the replicas to 1.
3. Once the InfluxDB 2.x is running, enter its shell and create a new `fronius_archive` bucket from CLI.
4. You should have now `netdata/autogen`, `fronius_live` and `fronius_archive` bucket.
   The last 2 should be empty for now.
5. Migrate & downsample the raw data from `netdata/autogen` bucket using the [scripts provided](files/influxdb/migration).
   You might need to edit the query a bit if you are deviating from the defaults.
   You can execute the scripts with `kubectl`, e.g.
   ```
   cat migration/<the-file>.flux | kubectl -n fronius exec -i fronius-influxdb-0 -- influx query -o fronius -t $INFLUX_TOKEN
   ```
6. Each migration script can take a few minutes.
   Check the Grafana dashboard if the values make sense.
7. Scale up the exporter and verify that values are stored in `fronius_live` bucket.
8. Create the downsampling task for `fronius_archive`, check out the ConfigMap in the Helm chart that would installed on first installation.
9. Delete the `netdata/autogen` bucket.

<!---
Common/Useful Link references from values.yaml
-->
[resource-units]: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes
[prometheus-operator]: https://github.com/coreos/prometheus-operator
[prom-relabel-config]: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#relabelconfig

## Source Code

* <https://github.com/ccremer/fronius-exporter>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://ccremer.github.io/charts | fronius(fronius-exporter) | 0.8.0 |
| https://helm.influxdata.com | influxdb(influxdb2) | 2.0.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| archival.bucket | string | `"fronius_archive"` | Name of the archival bucket to create after installation. |
| archival.enabled | bool | `true` | Whether long-term archival is enabled. Note: Disabling archival after installation (when enabled) does not remove the archival bucket. |
| archival.retention | string | `"0s"` | Retention of the archival bucket. `0s` means forever. |
| archival.window | string | `"10m"` | Fixed windows of time in which metrics are averaged. |
| fronius.enabled | bool | `true` |  |
| fronius.nameOverride | string | `"exporter"` |  |
| fronius.telegraf.enabled | bool | `true` |  |
| fronius.telegraf.globalTags.site | string | `"home"` | The name of the site or environment. |
| fronius.telegraf.influxdb.bucket | string | `"fronius_live"` | The high-precision bucket name, needs to be equal to `influxdb.adminUser.bucket`. |
| fronius.telegraf.influxdb.token | string | `""` | The token to connect to InfluxDB, needs to be equal to `influxdb.adminUser.token`. |
| fronius.telegraf.influxdb.url | string | `"http://fronius-influxdb"` |  |
| fronius.telegraf.interval | string | `"5s"` | Interval of sending metrics to InfluxDB. |
| fullnameOverride | string | `""` |  |
| grafana.dashboard.enabled | bool | `true` |  |
| grafana.dashboard.labels | object | `{"grafana_dashboard":"1"}` | The labels which the sidecar is filtering for dashboards. |
| grafana.dashboard.namespace | string | `""` | Override the namespace where the ConfigMap is installed, defaults to release namespace. |
| grafana.datasource.enabled | bool | `true` |  |
| grafana.datasource.labels | object | `{"grafana_datasource":"1"}` | The labels which the sidecar is filtering for data sources. |
| grafana.datasource.namespace | string | `""` | Override the namespace where the ConfigMap is installed, defaults to release namespace. |
| influxdb.adminUser.bucket | string | `"fronius_live"` |  |
| influxdb.adminUser.organization | string | `"fronius"` |  |
| influxdb.adminUser.retention_policy | string | `"14d"` |  |
| influxdb.enabled | bool | `true` |  |
| influxdb.pdb.create | bool | `false` |  |
| influxdb.persistence.size | string | `"2Gi"` |  |
| influxdb.resources.limits.memory | string | `"256Mi"` |  |
| influxdb.resources.requests.cpu | string | `"50m"` |  |
| influxdb.resources.requests.memory | string | `"128Mi"` |  |
| nameOverride | string | `"fronius"` |  |
