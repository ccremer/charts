# kubernetes-zfs-provisioner

![Version: 0.2.8](https://img.shields.io/badge/Version-0.2.8-informational?style=flat-square) ![AppVersion: 0.2.1](https://img.shields.io/badge/AppVersion-0.2.1-informational?style=flat-square)

Dynamic ZFS persistent volume provisioner for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| env | object | `{}` | A dict with KEY: VALUE pairs |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"docker.io"` | Container image registry |
| image.repository | string | `"ccremer/zfs-provisioner"` | Location of the container image |
| image.tag | string | `"v0.3.0"` | Container image tag |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | Reminder: This has no effect on any PVs, but maybe you want the provisioner pod running on certain nodes. |
| podSecurityContext | object | `{}` | If you encounter **issues with SSH, set `podSecurityContext.fsGroup=100`**, as the SSH files might not be readable to the container user `zfs` with uid 100. |
| provisioner.instance | string | `"pv.kubernetes.io/zfs"` | Provisoner instance name if multiple are running (multiple instances are not required for managing multiple ZFS hosts) |
| rbac.create | bool | `false` | **Required for first time deployments** Grant the service account the necessary permissions, |
| replicaCount | int | `1` | Usually `1` is fine |
| resources.limits.memory | string | `"40Mi"` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"20Mi"` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| ssh.config | string | `""` | **Required.** ssh_config(5)-compatible file content to configure SSH options when connecting |
| ssh.externalSecretName | string | `""` | If SSH secrets are managed externally, specify the name |
| ssh.identities | object | `{}` | **Required.** Provide a private key for each SSH identity, see values.yaml for an example |
| ssh.knownHosts | list | `[]` | **Required.** List of {host, pubKey} dicts where the public key of each host is configured |
| ssh.mountPath | string | `"/home/zfs/.ssh"` | The path where the SSH config and identities are mounted |
| storageClass.classes[0].hostName | string | `"storage-1.domain.tld"` | The provisioners connects through SSH to this ZFS host |
| storageClass.classes[0].name | string | `"zfs"` |  |
| storageClass.classes[0].node | string | `""` | Override `kubernetes.io/hostname` from `hostName` parameter for `HostPath` node affinity |
| storageClass.classes[0].parentDataset | string | `"tank/kubernetes"` | Existing dataset on the target ZFS host |
| storageClass.classes[0].policy | string | `"Delete"` | The reclaim policy supported by the provisioner |
| storageClass.classes[0].shareProperties | string | `""` | NFS export properties (see `exports(5)`) |
| storageClass.classes[0].type | string | `"nfs"` | Provision type, one of [`nfs`, `hostpath`] |
| storageClass.create | bool | `false` | Whether to create storage classes for this provisioner. One example is given in the `classes` array |
| tolerations | list | `[]` |  |
