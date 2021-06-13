{{/*
Expand the name of the chart.
*/}}
{{- define "fronius-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fronius-stack.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fronius-stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fronius-stack.labels" -}}
helm.sh/chart: {{ include "fronius-stack.chart" . }}
{{ include "fronius-stack.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fronius-stack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fronius-stack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fronius-stack.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "fronius-stack.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the full service name
*/}}
{{- define "fronius-stack.tld" -}}
{{ .Release.Namespace }}
{{- end }}
{{- define "fronius-stack.influxdb-host" -}}
http://{{ template "influxdb.fullname" . }}-influxdb.{{ .Release.Namespace }}:{{ .Values.influxdb.service.port | default 80 }}
{{- end }}

{{/*
Helper to define env vars for influxdb jobs
*/}}
{{- define "fronius-stack.influxdb-env" -}}
- name: INFLUX_HOST
  value: {{ template "fronius-stack.influxdb-host" . }}
- name: INFLUX_ORG
  value: {{ .Values.influxdb.adminUser.organization }}
- name: INFLUX_TOKEN
  valueFrom:
    secretKeyRef:
      {{- if .Values.influxdb.adminUser.existingSecret }}
      name: {{ .Values.influxdb.adminUser.existingSecret -}}
      {{ else }}
      name: {{ template "fronius-stack.fullname" . }}-influxdb-auth
      {{- end }}
      key: admin-token
{{- end }}
