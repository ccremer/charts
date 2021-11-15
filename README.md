# Charts

[![License](https://img.shields.io/github/license/ccremer/charts)](https://github.com/ccremer/charts/blob/master/LICENSE)
[![Downloads](https://img.shields.io/github/downloads/ccremer/charts/total)](https://github.com/ccremer/charts/releases)

[ccremer](https://github.com/ccremer)'s Helm charts repository

## List of Charts

| Downloads & Changelog | Chart |
| --- | --- |
| [![chart downloads](https://img.shields.io/github/downloads/ccremer/charts/clustercode-0.1.2/total)](https://github.com/ccremer/charts/releases/tag/clustercode-0.1.2) | [clustercode](charts/clustercode/README.md) |
| [![chart downloads](https://img.shields.io/github/downloads/ccremer/charts/emby-0.2.2/total)](https://github.com/ccremer/charts/releases/tag/emby-0.2.2) | [emby](charts/emby/README.md) |
| [![chart downloads](https://img.shields.io/github/downloads/ccremer/charts/fronius-exporter-0.8.1/total)](https://github.com/ccremer/charts/releases/tag/fronius-exporter-0.8.1) | [fronius-exporter](charts/fronius-exporter/README.md) |
| [![chart downloads](https://img.shields.io/github/downloads/ccremer/charts/fronius-stack-0.1.3/total)](https://github.com/ccremer/charts/releases/tag/fronius-stack-0.1.3) | [fronius-stack](charts/fronius-stack/README.md) |
| [![chart downloads](https://img.shields.io/github/downloads/ccremer/charts/kubernetes-zfs-provisioner-1.1.1/total)](https://github.com/ccremer/charts/releases/tag/kubernetes-zfs-provisioner-1.1.1) | [kubernetes-zfs-provisioner](charts/kubernetes-zfs-provisioner/README.md) |
| [![chart downloads](https://img.shields.io/github/downloads/ccremer/charts/samba-0.1.1/total)](https://github.com/ccremer/charts/releases/tag/samba-0.1.1) | [samba](charts/samba/README.md) |
| [![chart downloads](https://img.shields.io/github/downloads/ccremer/charts/znapzend-0.5.4/total)](https://github.com/ccremer/charts/releases/tag/znapzend-0.5.4) | [znapzend](charts/znapzend/README.md) |

## Development

### Testing

Scaffold chart unit tests by copying existing unit tests and place it into a `test` dir within your chart dir.
Develop your Go unit tests and make sure they run successfully.

To run all test, run `make test`.

### Documentation

This chart repository generates READMEs from [Helm-Docs](https://github.com/norwoodj/helm-docs/).
That means you have to format your `values.yaml` in a certain way.
See link or existing charts for examples.

The root README is also generated so that it links to the new chart.

You can generate the chart README.md with `make docs:helm`.

To generate all documentations, run `make docs`.
