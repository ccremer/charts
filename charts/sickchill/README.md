# sickchill

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for SickChill

## Installation

```bash
helm repo add ccremer https://ccremer.github.io/charts
helm install sickchill ccremer/sickchill
```

## Source Code

* <https://github.com/SickChill/SickChill>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"docker.io"` | Container image registry |
| image.repository | string | `"sickchill/sickchill"` | Location of the container image |
| image.tag | string | `"7120"` | Container image tag |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` | Additional annotations for the Ingress object |
| ingress.enabled | bool | `false` | Control whether ingress is created |
| ingress.hosts | list | `[]` | See Kubernetes Docs for a guide to setup Ingress hosts |
| ingress.tls | list | `[]` | See Kubernetes Docs for a guide to setup TLS on Ingress |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.data.annotations | object | `{}` | Additional annotations to add to the PVC |
| persistence.data.enabled | bool | `false` | Whether to enable the PVC and mount |
| persistence.data.selector | object | `{}` | PV selector |
| persistence.data.size | string | `"3Gi"` | Requested storage size |
| persistence.data.storageClass | string | `""` | Storage Class name of the PV |
| persistence.downloads.annotations | object | `{}` | Additional annotations to add to the PVC |
| persistence.downloads.enabled | bool | `false` | Whether to enable the PVC and mount |
| persistence.downloads.selector | object | `{}` | PV selector |
| persistence.downloads.size | string | `"3Gi"` | Requested storage size |
| persistence.downloads.storageClass | string | `""` | Storage Class name of the PV |
| persistence.shows.annotations | object | `{}` | Additional annotations to add to the PVC |
| persistence.shows.enabled | bool | `false` | Whether to enable the PVC and mount |
| persistence.shows.selector | object | `{}` | PV selector |
| persistence.shows.size | string | `"3Gi"` | Requested storage size |
| persistence.shows.storageClass | string | `""` | Storage Class name of the PV |
| podAnnotations | object | `{}` | The pod annotations |
| podSecurityContext | object | `{}` | The pod security context |
| replicaCount | int | `1` |  |
| resources.limits.memory | string | `"128Mi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"64Mi"` |  |
| securityContext | object | `{}` | The container security context |
| service.port | int | `8081` | Service http port number |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| sickchill.env | list | `[]` |  |
| tolerations | list | `[]` |  |
