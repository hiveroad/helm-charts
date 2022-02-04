{{/*
Expand the name of the chart.
*/}}
{{- define "goshimmer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "goshimmer.fullname" -}}
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
{{- define "goshimmer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "goshimmer.labels" -}}
helm.sh/chart: {{ include "goshimmer.chart" . }}
{{ include "goshimmer.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "goshimmer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "goshimmer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "goshimmer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "goshimmer.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Goshimmer port numbers base on portbase if nodeport service or fallback to default port numbers
*/}}

{{- define "goshimmer.ports.api" -}}
{{- eq .Values.service.type "NodePort" | ternary (add .Values.service.nodePort.portBase 1) 8080 }}
{{- end }}
{{- define "goshimmer.ports.dashboard" -}}
{{- eq .Values.service.type "NodePort" | ternary (add .Values.service.nodePort.portBase 2) 8081 }}
{{- end }}
{{- define "goshimmer.ports.profiling" -}}
{{- eq .Values.service.type "NodePort" | ternary (add .Values.service.nodePort.portBase 3) 6061 }}
{{- end }}
{{- define "goshimmer.ports.prometheus" -}}
{{- eq .Values.service.type "NodePort" | ternary (add .Values.service.nodePort.portBase 4) 9311 }}
{{- end }}
{{- define "goshimmer.ports.autopeering" -}}
{{- eq .Values.service.type "NodePort" | ternary (add .Values.service.nodePort.portBase 5) 14626 }}
{{- end }}
{{- define "goshimmer.ports.gossip" -}}
{{- eq .Values.service.type "NodePort" | ternary (add .Values.service.nodePort.portBase 6) 14666 }}
{{- end }}
{{- define "goshimmer.ports.fpc" -}}
{{- eq .Values.service.type "NodePort" | ternary (add .Values.service.nodePort.portBase 7) 10895 }}
{{- end }}
{{- define "goshimmer.ports.txstream" -}}
{{- eq .Values.service.type "NodePort" | ternary (add .Values.service.nodePort.portBase 8) 5000 }}
{{- end }}