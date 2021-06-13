
## Prometheus Operator

This chart features templates for [Prometheus Operator][prometheus-operator] if desired.
If you'd like to add additional Prometheus labels to all metrics, you could make use of relabelings:

```yaml
serviceMonitor:
  enabled: true
  metricRelabelings:
    - targetLabel: site
      replacement: my-home
```

<!---
Common/Useful Link references from values.yaml
-->
[resource-units]: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes
[prometheus-operator]: https://github.com/coreos/prometheus-operator
[prom-relabel-config]: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#relabelconfig
