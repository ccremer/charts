你好！
很冒昧用这样的方式来和你沟通，如有打扰请忽略我的提交哈。我是光年实验室（gnlab.com）的HR，在招Golang开发工程师，我们是一个技术型团队，技术氛围非常好。全职和兼职都可以，不过最好是全职，工作地点杭州。
我们公司是做流量增长的，Golang负责开发SAAS平台的应用，我们做的很多应用是全新的，工作非常有挑战也很有意思，是国内很多大厂的顾问。
如果有兴趣的话加我微信：13515810775  ，也可以访问 https://gnlab.com/，联系客服转发给HR。
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

* [emby](emby/README.md)
* [fronius-exporter](fronius-exporter/README.md)
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
