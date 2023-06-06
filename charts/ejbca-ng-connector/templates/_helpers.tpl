{{/*
Expand the name of the chart.
*/}}
{{- define "ejbca-ng-connector.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ejbca-ng-connector.fullname" -}}
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
{{- define "ejbca-ng-connector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ejbca-ng-connector.labels" -}}
helm.sh/chart: {{ include "ejbca-ng-connector.chart" . }}
{{ include "ejbca-ng-connector.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ejbca-ng-connector.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ejbca-ng-connector.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return the image name
*/}}
{{- define "ejbca-ng-connector.image" -}}
{{ include "czertainly-lib.images.image" (dict "image" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the image pull secret names
*/}}
{{- define "ejbca-ng-connector.imagePullSecrets" -}}
{{ include "czertainly-lib.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{/*
Retun the ephemeral volume configuration
*/}}
{{- define "ejbca-ng-connector.ephemeralVolume" -}}
{{ include "czertainly-lib.volumes.ephemeral" (dict "volumes" .Values.volumes "global" .Values.global.volumes) }}
{{- end -}}
