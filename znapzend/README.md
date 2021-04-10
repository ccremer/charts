# znapzend

![Version: 0.5.4](https://img.shields.io/badge/Version-0.5.4-informational?style=flat-square)

Znapzend Helm Chart for automated ZFS snapshot & replication

## Installation

```bash
helm repo add ccremer https://ccremer.github.io/charts
helm install znapzend ccremer/znapzend
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| env | object | `{}` | A dict with `KEY: VALUE` pairs |
| fullnameOverride | string | `""` |  |
| host.zfsDevice | string | `"/dev/zfs"` | The device on the host which is used by the `zfs` binary within the container |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"docker.io"` | Znapzend image registry |
| image.repository | string | `"oetiker/znapzend"` | Znapzend image repository |
| image.tag | string | `"v0.20.0"` | Znapzend image tag (version) |
| imagePullSecrets | list | `[]` | List of image pull secrets if you use a privately hosted image |
| metrics.enabled | bool | `true` | Enable the metrics exporter for Prometheus |
| metrics.env | object | `{}` | A dict with `KEY: VALUE` pairs as environment variables for the exporter |
| metrics.image.pullPolicy | string | `"IfNotPresent"` |  |
| metrics.image.registry | string | `"docker.io"` | Image registry |
| metrics.image.repository | string | `"ccremer/znapzend-exporter"` | Image repository |
| metrics.image.tag | string | `"v0.3.2"` | Exporter image tag |
| metrics.ingress.annotations | object | `{}` |  |
| metrics.ingress.enabled | bool | `false` | Useful if your Prometheus is outside of the cluster |
| metrics.ingress.hosts | list | `[]` |  |
| metrics.ingress.tls | list | `[]` |  |
| metrics.jobs.register | list | `[]` | String list of datasets that should be registered right at startup |
| metrics.port | int | `8080` | Container port to bind |
| metrics.resources.limits.memory | string | `"40Mi"` |  |
| metrics.resources.requests.cpu | string | `"20m"` |  |
| metrics.resources.requests.memory | string | `"20Mi"` |  |
| metrics.service.enabled | bool | `true` | Whether to enable a Service object for metrics endpoint if metrics.enabled is true |
| metrics.service.nodePort | int | `0` | NodePort if service type is not ClusterIP |
| metrics.service.port | int | `8080` | Port on which the service is reachable |
| metrics.service.type | string | `"ClusterIP"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` | Only increase if you have multiple Nodes with AntiAffinity, otherwise it does not make sense to run > 1 replicas on the same node |
| resources.limits.memory | string | `"70Mi"` |  |
| resources.requests.cpu | string | `"30m"` |  |
| resources.requests.memory | string | `"30Mi"` |  |
| securityContext | object | `{"allowPrivilegeEscalation":true,"privileged":true}` | The current image requires to run privileged in order to access ZFS |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| ssh.config | string | `""` | `ssh_config(5)`-compatible file content to configure SSH options when connecting |
| ssh.externalSecretName | string | `""` | Set this value if you provide your own secret with SSH config |
| ssh.identities | object | `{}` | Provide a private key for each SSH identity, see [values.yaml](./values.yaml) for an example |
| ssh.knownHosts | list | `[]` | List of `{host, pubKey}` dicts where the public key of each host is configured |
| ssh.path | string | `"/root/.ssh"` | Path where your SSH config and identities get mounted in the container |
| tolerations | list | `[]` |  |
| znapzend.args | list | `["znapzend","--logto=/dev/stdout","--autoCreation"]` | List of command arguments |
| znapzend.backupPlans | list | `[]` | List of backup plans to create/ensure on startup, see [values.yaml](./values.yaml) for an example |
| znapzend.reloadPlans | bool | `true` | Whether znapzend should reload the `znapzend.backupPlans` after modifying them. Creates additional RBAC roles for the `serviceAccount.name` |
