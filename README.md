# Charts

[![License](https://img.shields.io/github/license/ccremer/charts)](https://github.com/ccremer/charts/blob/master/LICENSE)
[![Downloads](https://img.shields.io/github/downloads/ccremer/charts/total)](https://github.com/ccremer/charts/releases)

[ccremer](https://github.com/ccremer)'s Helm charts repository

All Charts can be installed with
```
helm repo add ccremer https://ccremer.github.io/charts
helm install ccremer/<chart_name>
```

## List of Charts

* [kubernetes-zfs-provisioner](kubernetes-zfs-provisioner/README.md)
* [znapzend](znapzend/README.md)

## Development

### New Charts:

All Charts should created with API v1 (Helm 2 compatible), so be sure to delete
the `type` key from `Chart.yaml`

```
helm create <chart_name>
```

Then create the Chart templates

### Testing

Scaffold chart unit tests by copying an existing `go.mod`, e.g. from `znapzend/test/go.mod`
and place it into a `test` dir. Develop your Go unit tests and make sure they run successfully.

To run all test, run `make tests`

### Documentation

This chart repository generates READMEs from [Helm-Docs](https://github.com/norwoodj/helm-docs/).
That means you have to format your `values.yaml` in a certain way. See link or existing charts
for examples.

The root README is also generated so that it links to the new chart.

You can generate the chart README.md with `make helm-docs`.

To generate all documentations, run `make docs`
