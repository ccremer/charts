# Charts

[![License](https://img.shields.io/github/license/ccremer/charts)](https://github.com/ccremer/charts/blob/master/LICENSE)
[![Downloads](https://img.shields.io/github/downloads/ccremer/charts/total)](https://github.com/ccremer/charts/releases)

[ccremer](https://github.com/ccremer)'s Helm charts repository

## List of Charts

* [clustercode](charts/clustercode/README.md)
* [emby](charts/emby/README.md)
* [fronius-exporter](charts/fronius-exporter/README.md)
* [fronius-stack](charts/fronius-stack/README.md)
* [kubernetes-zfs-provisioner](charts/kubernetes-zfs-provisioner/README.md)
* [samba](charts/samba/README.md)
* [znapzend](charts/znapzend/README.md)

## Development

### Testing

Scaffold chart unit tests by copying existing unit tests and place it into a `test` dir within your chart dir.
Develop your Go unit tests and make sure they run successfully.

To run all test, run `make test`

### Documentation

This chart repository generates READMEs from [Helm-Docs](https://github.com/norwoodj/helm-docs/).
That means you have to format your `values.yaml` in a certain way.
See link or existing charts for examples.

The root README is also generated so that it links to the new chart.

You can generate the chart README.md with `make docs:helm`.

To generate all documentations, run `make docs`
