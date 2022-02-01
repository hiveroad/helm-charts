{{/*
Expand the name of the chart.
*/}}
{{- define "wasp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wasp.fullname" -}}
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
{{- define "wasp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "wasp.labels" -}}
helm.sh/chart: {{ include "wasp.chart" . }}
{{ include "wasp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "wasp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wasp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "wasp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "wasp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate neibhors list
*/}}
{{- define "wasp.neighbors" -}}
{{- $prefix := (include "wasp.fullname" .)}}
{{- $serviceName := (include "wasp.fullname" .)}}
{{- $names := list }}
{{- range $index := until (int .Values.replicaCount) }}
{{- $names = append $names ( include "wasp.netid" $ ) }}
{{- end }}
{{- $names | join "," }}
{{- end}}


{{/*
Get the net id
*/}}
{{- define "wasp.netid" -}}

{{- if .Values.ingress.enabled }}
{{- printf "%s:%d" .Values.ingress.host (int .Values.wasp.ports.peering) }}
{{- else }}
{{- printf "%s:%d" ( include "wasp.fullname" . ) (int .Values.wasp.ports.peering) }}
{{- end }}
{{- end}}