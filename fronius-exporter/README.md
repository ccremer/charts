# fronius-exporter

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Prometheus Exporter for Fronius Symo Photovoltaics

**Homepage:** <https://github.com/ccremer/fronius-exporter>

## Installation

```bash
helm repo add ccremer https://ccremer.github.io/charts
helm install fronius-exporter ccremer/fronius-exporter
```

## Source Code

* <https://github.com/ccremer/fronius-exporter>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| exporter.additionalArgs | list | `[]` | Provide additional CLI flags via string array |
| exporter.siteName | string | `""` | Site name of Fronius SYMO that gets added as a static label to all metrics. **Recommended** |
| exporter.symoUrl | string | `"http://symo.ip.or.hostname/solar_api/v1/GetPowerFlowRealtimeData.fcgi"` | Target URL of Fronius SYMO device. **Required** |
| exporter.timeoutSeconds | int | `5` | Time after which collecting may time out. Should not be higher than the Prometheus scrape interval. |
| fullnameOverride | string | `""` |  |
| hostAliases | object | `{}` | A dict with `{ip, hostnames array}` to configure custom entries in /etc/hosts. See [values.yaml](./values.yaml) for an example. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"quay.io"` | Container image registry |
| image.repository | string | `"ccremer/fronius-exporter"` | Location of the container image |
| image.tag | string | `"v0.5.0"` | Container image tag |
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
| tolerations | list | `[]` |  |
