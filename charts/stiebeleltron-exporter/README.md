# stiebeleltron-exporter

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Prometheus Exporter for Stiebel Eltron heat pump ISG

**Homepage:** <https://github.com/ccremer/stiebeleltron-exporter>

## Installation

```bash
helm repo add ccremer https://ccremer.github.io/charts
helm install stiebeleltron-exporter ccremer/stiebeleltron-exporter
```

## Prometheus Operator

This chart features templates for [Prometheus Operator][prometheus-operator] if desired.
If you'd like to add additional Prometheus labels to all metrics, you could make use of relabelings:

```yaml
serviceMonitor:
  enabled: true
  metricRelabelings:
    - targetLabel: site
      replacement: my-home
```

<!---
Common/Useful Link references from values.yaml
-->
[resource-units]: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes
[prometheus-operator]: https://github.com/coreos/prometheus-operator
[prom-relabel-config]: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#relabelconfig

## Source Code

* <https://github.com/ccremer/stiebeleltron-exporter>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| exporter.additionalArgs | list | `[]` | Provide additional CLI flags via string array |
| exporter.isgUrl | string | `"http://isg.ip.or.hostname"` | Target URL of Stiebel Eltron ISG device. **Required** |
| exporter.timeoutSeconds | int | `5` | Time after which collecting may time out. Should not be higher than the Prometheus scrape interval. |
| fullnameOverride | string | `""` |  |
| hostAliases | object | `{}` | A dict with `{ip, hostnames array}` to configure custom entries in /etc/hosts. See [values.yaml](./values.yaml) for an example. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"ghcr.io"` | Container image registry |
| image.repository | string | `"ccremer/stiebeleltron-exporter"` | Location of the container image |
| image.tag | string | `"v0.1.2"` | Container image tag |
| imagePullSecrets | list | `[]` | List of image pull secrets if you use a privately hosted image |
| ingress.annotations | object | `{}` | Additional annotations for the Ingress object |
| ingress.enabled | bool | `false` | Useful if your Prometheus is outside of the cluster |
| ingress.hosts | list | `[]` | See Kubernetes Docs for a guide to setup Ingress hosts |
| ingress.tls | list | `[]` | See Kubernetes Docs for a guide to setup TLS on Ingress |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` | Usually `1` is fine |
| resources.limits.memory | string | `"64Mi"` |  |
| resources.requests.cpu | string | `"20m"` |  |
| resources.requests.memory | string | `"32Mi"` |  |
| securityContext | object | `{}` |  |
| service.nodePort | int | `0` | Node port number if `type` is `NodePort` |
| service.port | int | `8080` | Service port number |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and `create` is `true`, a name is generated using the fullname template |
| serviceMonitor.additionalLabels | object | `{}` | Add custom labels to the ServiceMonitor object |
| serviceMonitor.enabled | bool | `false` | Deploy a ServiceMonitor object for Prometheus. Requires an installed [Prometheus Operator][prometheus-operator]. |
| serviceMonitor.metricRelabelings | list | `[]` | Add relabeling configs before ingestion, see [RelabelConfig][prom-relabel-config]. |
| serviceMonitor.namespace | string | `""` | Namespace in which to deploy the ServiceMonitor, defaults to release namespace. |
| serviceMonitor.scrapeInterval | string | `""` | Override default scrape interval from Prometheus |
| telegraf.enabled | bool | `false` | Whether to enable Telegraf sidecar for Influxdb |
| telegraf.globalTags | object | `{}` | A dict with `key: value` to add to `global_tags` config |
| telegraf.image.registry | string | `"docker.io"` |  |
| telegraf.image.repository | string | `"library/telegraf"` | Telegraf image location |
| telegraf.image.tag | string | `"1.20-alpine"` | Telegraf image tag |
| telegraf.influxdb.bucket | string | `"stiebeleltron"` | Bucket to write metrics into |
| telegraf.influxdb.organization | string | `"stiebeleltron"` | Organization where the bucket belongs to |
| telegraf.influxdb.token | string | `""` | Token used to authenticate to InfluxDB |
| telegraf.influxdb.url | string | `"http://influxdb2"` | URL of an InfluxDB 2 instance |
| telegraf.interval | string | `"30s"` | Go-style interval in which metrics are pushed to InfluxDB |
| tolerations | list | `[]` |  |
