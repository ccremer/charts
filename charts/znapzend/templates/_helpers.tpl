{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "znapzend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "znapzend.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "znapzend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "znapzend.labels" -}}
helm.sh/chart: {{ include "znapzend.chart" . }}
{{ include "znapzend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "znapzend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "znapzend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "znapzend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "znapzend.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Define SelfReset
*/}}
{{- define "metrics.selfReset" -}}
SelfResetAfter={{ default "1h" .selfResetAfter }}
{{- end -}}

{{/*
Common Volumes
*/}}
{{- define "znapzend.volumes" -}}
- name: zfs
  hostPath:
    path: "{{ .Values.host.zfsDevice }}"
    type: CharDevice
{{ $secretName := include "znapzend.fullname" . }}
{{- with .Values.ssh -}}
{{- if or .identities .externalSecretName }}
- name: ssh
  secret:
    {{- if .externalSecretName }}
    secretName: {{ .externalSecretName }}
    {{- else }}
    secretName: {{ $secretName }}
    {{- end }}
    defaultMode: 0600
{{- end }}
{{- end }}
{{- end }}
