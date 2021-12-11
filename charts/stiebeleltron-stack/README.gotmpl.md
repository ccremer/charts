> ⚠️ **WARNING**: See [data retention](#data-retention) first!

## About

This Helm chart installs the stiebeleltron-exporter along with long-term storage and a Grafana dashboard.
The goal is to be able to do statistics of the photovoltaic installation.

I wanted to keep stiebeleltron-exporter Helm chart minimal in case you're only interested in the exporter or you're bringing your own metrics stack.

## Features

* stiebeleltron-exporter chart
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

stiebeleltron:
  exporter:
    isgUrl: http://your.isg.device.or.ip/
  telegraf:
    influxdb:
      token: changeme # should be the same as `influxdb.adminUser.token`!
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
Make sure the stiebeleltron ISG device, InfluxDB and Grafana dashboard are roughly in the same timezone.
The stiebeleltron ISG console includes counters like "energy per day" that reset at midnight.

## Migrating from netdata plugin

If you have used the stiebeleltron plugin that is part of netdata, you can migrate the data to the exporter variant.

As this step is done manually once, it's not automated, but here's roughly how I did it:

1. Install this chart but don't start the exporter and influxdb yet (0 replicas each).
   Also disable the archival feature for now.
2. Modify the InfluxDB 2.x StatefulSet, so that you can migrate using the Docker approach.
   You'd need to set `DOCKER_INFLUXDB_INIT_MODE=upgrade` and add the volume from the old DB.
   You can now scale the replicas to 1.
3. Once the InfluxDB 2.x is running, enter its shell and create a new `stiebeleltron_archive` bucket from CLI.
4. You should have now `netdata/autogen`, `stiebeleltron_live` and `stiebeleltron_archive` bucket.
   The last 2 should be empty for now.
5. Migrate & downsample the raw data from `netdata/autogen` bucket using the [scripts provided](files/influxdb/migration).
   You might need to edit the query a bit if you are deviating from the defaults.
   You can execute the scripts with `kubectl`, e.g.
   ```
   cat migration/<the-file>.flux | kubectl -n stiebeleltron exec -i stiebeleltron-influxdb-0 -- influx query -o stiebeleltron -t $INFLUX_TOKEN
   ```
6. Each migration script can take a few minutes.
   Check the Grafana dashboard if the values make sense.
7. Scale up the exporter and verify that values are stored in `stiebeleltron_live` bucket.
8. Create the downsampling task for `stiebeleltron_archive`, check out the ConfigMap in the Helm chart that would installed on first installation.
9. Delete the `netdata/autogen` bucket.

<!---
Common/Useful Link references from values.yaml
-->
[resource-units]: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes
[prometheus-operator]: https://github.com/coreos/prometheus-operator
[prom-relabel-config]: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#relabelconfig
