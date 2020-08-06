emby
====
A Helm chart for Emby media server

Current chart version is `0.1.1`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalVolumeMounts | list | `[]` | Add custom volume mounts to the deployment |
| additionalVolumes | list | `[]` | Add custom volumes to the deployment (may need to match `additionalVolumeMounts`) |
| affinity | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | Container image pull policy |
| image.registry | string | `"docker.io"` | Container image registry |
| image.repository | string | `"emby/embyserver"` | Location of the container image |
| image.tag | string | `"4.5.0.16"` | Container image tag |
| imagePullSecrets | list | `[]` | List of image pull secrets if you use a privately hosted image |
| ingress.annotations | object | `{}` | Additional annotations for the Ingress object |
| ingress.enabled | bool | `false` | Control whether ingress is created |
| ingress.hosts | list | `[]` | See Kubernetes Docs for a guide to setup TLS on Ingress |
| ingress.tls | list | `[]` |  |
| livenessProbe.enabled | bool | `true` | Whether to enable the liveness probe |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.annotations | object | `{}` | Additional annotations to add to the PVC |
| persistence.enabled | bool | `false` | Whether to enable the PVC and mount |
| persistence.mountPath | string | `"/config"` |  |
| persistence.selector | object | `{}` | PV selector |
| persistence.size | string | `"3Gi"` | Requested storage size |
| persistence.storageClass | string | `""` | Storage Class name of the PV |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.enabled | bool | `true` | Whether to enable the readiness probe |
| replicaCount | int | `1` |  |
| resources.limits.memory | string | `"768Mi"` |  |
| resources.requests.cpu | string | `"30m"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| securityContext | object | `{}` |  |
| service.httpNodePort | int | `0` | http Node port number if `service.type` is `NodePort` |
| service.httpPort | int | `8096` | Service http port number |
| service.httpsNodePort | int | `0` | https Node port number if `service.type` is `NodePort` |
| service.httpsPort | int | `8920` | Service https port number |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and `create` is `true`, a name is generated using the fullname template |
| tolerations | list | `[]` |  |
