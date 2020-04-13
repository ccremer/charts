kubernetes-zfs-provisioner
==========================
Dynamic ZFS persistent volume provisioner for Kubernetes

Current chart version is `0.1.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| env | object | `{}` | A dict with KEY: VALUE pairs |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"docker.io/ccremer/zfs-provisioner"` | Location of the container image |
| image.tag | string | `"v0.1.0"` | Container image tag |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | Reminder: This has no effect on any PVs, but maybe you want the provisioner pod running on certain nodes. |
| podSecurityContext | object | `{}` |  |
| provisioner.externalSecretName | string | `""` | If SSH secrets are managed externally, specify the name |
| provisioner.instance | string | `"pv.kubernetes.io/zfs"` | Provisoner instance name if multiple are running (multiple instances are not required for managing multiple ZFS hosts) |
| rbac.create | bool | `false` | **Required for first time deployments** Grant the service account the necessary permissions, |
| replicaCount | int | `1` | Usually `1` is fine |
| resources.limits.memory | string | `"100Mi"` |  |
| resources.requests.cpu | string | `"10m"` |  |
| resources.requests.memory | string | `"20Mi"` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| ssh.config | string | `""` | **Required.** ssh_config(5)-compatible file content to configure SSH options when connecting |
| ssh.externalSecretName | string | `""` | If SSH secrets are managed externally, specify the name |
| ssh.identities | object | `{}` | **Required.** Provide a private key for each SSH identity, see values.yaml for an example |
| ssh.knownHosts | string | `nil` | **Required.** List of {host, pubKey} dicts where the public key of each host is configured |
| ssh.mountPath | string | `"/home/zfs/.ssh"` | The path where the SSH config and identities are mounted |
| tolerations | list | `[]` |  |
