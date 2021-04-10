
## CRDs

This chart **does not include CRDs**.
Install or update CRDs manually with this command:
```bash
kubectl apply -f {{ (index .Sources 0) }}/releases/download/{{ template "chart.appVersion" . }}/{{ .Name }}-crd.yaml
 ```
