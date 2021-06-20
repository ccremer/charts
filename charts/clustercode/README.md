# clustercode

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.0.0-rc2](https://img.shields.io/badge/AppVersion-v2.0.0--rc2-informational?style=flat-square)

Movie and Series conversion Operator

**Homepage:** <https://ccremer.github.io/clustercode-docs>

## Installation

```bash
helm repo add ccremer https://ccremer.github.io/charts
helm install clustercode ccremer/clustercode
```

## CRDs

This chart **does not include CRDs**.
Install or update CRDs manually with this command:
```bash
kubectl apply -f https://github.com/ccremer/clustercode/releases/download/v2.0.0-rc2/clustercode-crd.yaml
```

## Source Code

* <https://github.com/ccremer/clustercode>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | The operator's pod affinity |
| clustercode.env | list | `[]` | Set additional environment variables to the Operator |
| clustercode.ffmpegImage.registry | string | `"docker.io"` |  |
| clustercode.ffmpegImage.repository | string | `"jrottenberg/ffmpeg"` |  |
| clustercode.ffmpegImage.tag | string | `"4.3-alpine"` |  |
| clustercode.leaderElectionEnabled | bool | `true` | Specifies whether leader election should be enabled |
| clustercode.watchNamespace | string | `""` | Specify which namespace to watch for Clustercode resources. If empty, all namespaces will be watched. |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"quay.io"` |  |
| image.repository | string | `"ccremer/clustercode"` |  |
| image.tag | string | `"v2.0.0-rc2"` |  |
| imagePullSecrets | list | `[]` |  |
| metrics.enabled | bool | `false` | Specifies whether metrics should be enabled |
| metrics.service.port | int | `9090` |  |
| metrics.service.type | string | `"ClusterIP"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | The operator's pod node selector |
| podAnnotations | object | `{}` | The operator's pod annotations |
| podSecurityContext | object | `{}` | The operator's pod security context |
| rbac.create | bool | `true` | Specifies whether RBAC roles and rolebindings should be enabled |
| replicaCount | int | `1` | The operator's pod replica count |
| resources.limits.memory | string | `"128Mi"` |  |
| resources.requests.cpu | string | `"10m"` |  |
| resources.requests.memory | string | `"32Mi"` |  |
| securityContext | object | `{}` | The operator's container security context |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | The operator's pod tolerations |
