# Znapzend Chart

[Znapzend](https://github.com/oetiker/znapzend) - zfs backup with remote capabilities and mbuffer integration. http://www.znapzend.org

[Znapzend Exporter](https://github.com/ccremer/znapzend-exporter) - a Znapzend exporter for Prometheus

## TL;DR;

```console
helm install ccremer/znapzend
```

> **Important**: By default, znapzend runs as a privileged container in order to access ZFS.

## Configuration

The following table lists the configurable chart specific parameters. For default values consult `values.yaml`.

| Parameter                          | Description |
| ---                                | --- |
| `host.zfsDevice`                   | Path of the ZFS device on the host (bind-mounted to container) |
| `ssh.path`                         | Path where the SSH files are being mounted |
| `ssh.config`                       | Specify the contents of the `ssh_config(5)` config file |
| `ssh.identities`                   | List all private keys to access remote SSH server for znapzend targets |
| `ssh.knownHosts`                   | List of known_hosts entries |
| `ssh.knownHosts[].host`            | Hostname of the known Host |
| `ssh.knownHosts[].pubKey`          | Public Key of the known Host (e.g. `ssh-rsa AA...`) |
| `ssh.externalSecretName`           | Specify the name of the existing secret with the private keys, makes `ssh.knownHosts`, `ssh.config` and `ssh.identities` ineffective |
| `metrics.enabled`                  | If the znapzend-exporter should be enabled |
| `metrics.jobs.register[]`          | List of ZFS datasets that are expected in the metrics |
| `metrics.env`                      | Additional environment Variables for znapzend-exporter |
| `metrics.service.enabled`          | Whether the metrics service is enabled for Prometheus scrapes |

There are far more parameters, including common ones (`image.tag`, etc.)

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
helm install --name my-release -f values.yaml ccremer/znapzend
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Testing

### Template testing

This chart uses some Go code to test the generated templates against the
Kubernetes client API. With this we are more flexible than `helm lint`, as
linting would not catch errors such as: "If we are in clustered mode, we expect
an init container, otherwise not". The test code would also catch typos in a
limited manner (e.g. if `initContainer` is spelled `initcontainer`, it will
generate an error).

```console
cd znapzend
helm dep build
cd test
go test ./...
```
