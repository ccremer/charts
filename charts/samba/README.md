# samba

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

A Helm chart for Samba server

## Installation

```bash
helm repo add ccremer https://ccremer.github.io/charts
helm install samba ccremer/samba
```
## Limitations

`samba.shares` and `samba.users` are translated into indexed environment variables, e.g. `SHARE0` and `USER0`.
Unfortunately, there cannot be an 11th share or user definition, as `SHARE10` gets confused with `SHARE1` (and likewise with `USERx`).

To workaround this limitation, use the `samba.args` and construct the definitions on your own using the script arguments.
Refer to [dperson/samba](https://github.com/dperson/samba) on how to do this.

## Source Code

* <https://github.com/dperson/samba>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.registry | string | `"docker.io"` |  |
| image.repository | string | `"dperson/samba"` |  |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessMode | string | `"ReadWriteMany"` | Access mode for the PV |
| persistence.annotations | object | `{}` | Additional annotations to add to the PVC |
| persistence.enabled | bool | `false` | Whether a PVC shall be created |
| persistence.mountPath | string | `"/data"` |  |
| persistence.selector | object | `{}` | PV selector |
| persistence.size | string | `"8Gi"` | Size of the PVC |
| persistence.storageClass | string | `""` | Storage Class name of the PV |
| persistence.volumeMounts | list | `[]` | Additional volume mounts, regardless of `enabled`. See [values.yaml](values.yaml) for an example. |
| persistence.volumes | list | `[]` | Additional volumes, regardless of `enabled`. See [values.yaml](values.yaml) for an example. |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` | Be sure to make use of tolerations or affinity rules if you scale higher than 1. |
| resources.limits.memory | string | `"512Mi"` |  |
| resources.requests.cpu | string | `"30m"` |  |
| resources.requests.memory | string | `"64Mi"` |  |
| samba.args | list | `[]` | Container args to pass |
| samba.existingSecretName | string | `""` | Name of an existing secret with USER env var(s). Refer to `templates/secret.yaml` for the format. |
| samba.rawEnv | object | `{}` | A dict with KEY: VALUE entries to directly define environment variables. |
| samba.shares | list | `[]` | A list of Samba shares. Convenience wrapper around SHARE env var(s). See [values.yaml](values.yaml) for an example. |
| samba.users | list | `[]` | A list of users as a convenience wrapper around USER env var(s). See [values.yaml](values.yaml) for an example. |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
