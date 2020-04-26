nextcloud
=========
A file sharing server that puts the control and security of your own data back into your hands.
This Chart was mostly copied from Stable but adapted to suit my needs


Current chart version is `0.1.0`





## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `10` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| cronjob.affinity | object | `{}` |  |
| cronjob.annotations | object | `{}` |  |
| cronjob.enabled | bool | `false` | Deploy a CronJob for nextcloud background tasks |
| cronjob.failedJobsHistoryLimit | int | `2` |  |
| cronjob.image | object | `{"pullPolicy":"","pullSecrets":[],"repository":"","tag":""}` | Nexcloud image is used as default but only curl is needed |
| cronjob.nodeSelector | object | `{}` |  |
| cronjob.resources.limits.memory | string | `"64Mi"` |  |
| cronjob.resources.requests.cpu | string | `"20m"` |  |
| cronjob.resources.requests.memory | string | `"16Mi"` |  |
| cronjob.schedule | string | `"*/15 * * * *"` | Setting this to any any other value than 15 minutes might cause issues with how nextcloud background jobs are executed |
| cronjob.successfulJobsHistoryLimit | int | `1` |  |
| cronjob.tolerations | list | `[]` |  |
| database.host | string | `""` |  |
| database.name | string | `"nextcloud"` |  |
| database.password | string | `""` |  |
| database.tableprefix | string | `""` |  |
| database.type | string | `"sqlite"` |  |
| database.user | string | `"nextcloud"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"docker.io/library/nextcloud"` | Location of the container image |
| image.tag | string | `"18.0.4-apache"` | Container image tag |
| imagePullSecrets | list | `[]` | List of image pull secrets if you use a privately hosted image |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.tls.enabled | bool | `true` |  |
| ingress.tls.secretName | string | `""` |  |
| nameOverride | string | `""` |  |
| nextcloud.configs | object | `{}` | Extra config files created in /var/www/html/config/, see https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#multiple-config-php-file |
| nextcloud.datadir | string | `"/var/www/html/data"` | Location of the data directory |
| nextcloud.defaultConfigs.".htaccess" | bool | `true` | To protect /var/www/html/config |
| nextcloud.defaultConfigs."apache-pretty-urls.config.php" | bool | `true` | Apache configuration for rewrite urls |
| nextcloud.defaultConfigs."apcu.config.php" | bool | `true` | Define APCu as local cache |
| nextcloud.defaultConfigs."apps.config.php" | bool | `true` | Apps directory configs |
| nextcloud.defaultConfigs."autoconfig.php" | bool | `true` | Used for auto configure database |
| nextcloud.defaultConfigs."redis.config.php" | bool | `true` | Redis default configuration |
| nextcloud.defaultConfigs."smtp.config.php" | bool | `true` | SMTP default configuration |
| nextcloud.host | string | `""` | Base URL of the nextcloud instance **Required** |
| nextcloud.mail.domain | string | `""` | Mail sender domain, e.g. `domain.com` |
| nextcloud.mail.enabled | bool | `false` | Whether to configure email notifications, password resets etc. |
| nextcloud.mail.fromAddress | string | `"nextcloud"` | Mail sender name |
| nextcloud.mail.smtp.authtype | string | `"LOGIN"` | SMTP server authentication type, `LOGIN` or `PLAIN` |
| nextcloud.mail.smtp.host | string | `""` | SMTP server hostname, e.g. `smtp.domain.com` |
| nextcloud.mail.smtp.name | string | `"user"` | Login name for SMTP |
| nextcloud.mail.smtp.password | string | `"pass"` | Login password for SMTP |
| nextcloud.mail.smtp.port | int | `465` | SMTP server port |
| nextcloud.mail.smtp.secure | string | `""` | Enable SMTPS with `ssl` or more securely with TLS with `tls` |
| nextcloud.password | string | `""` | Admin password, random password if left empty |
| nextcloud.phpConfigs | object | `{}` | PHP Configuration files injected in /usr/local/etc/php/conf.d |
| nextcloud.update | int | `0` | Whether a nextcloud update is required (e.g. if you upgrade nextcloud version) |
| nextcloud.username | string | `"admin"` | Admin username to be created when initializing the instance |
| nodeSelector | object | `{}` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` | Additional annotations for the PVC |
| persistence.enabled | bool | `false` |  |
| persistence.existingClaim | string | `""` | A manually managed Persistent Volume and Claim, requires `persistence.enabled: true` |
| persistence.size | string | `"8Gi"` |  |
| persistence.storageClass | string | `""` | Storage class name for dynamic provisioning. If empty, default provisioner is used |
| persistence.subPath | string | `""` | Optional subpath within the volume |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` | Security context of the pod |
| replicaCount | int | `1` |  |
| resources.limits.memory | string | `"512Mi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| securityContext | object | `{}` | Security context of the container |
| service.loadBalancerIP | string | `""` | The IP of the service if type is `LoadBalancer` |
| service.port | int | `80` | Port on which the service is reachable |
| service.type | string | `"ClusterIP"` | Type of the service |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |
