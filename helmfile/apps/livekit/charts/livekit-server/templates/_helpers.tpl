{{/*

SPDX-License-Identifier: APACHE-2.0
*/}}

{{/*
Return the proper livekit image name
*/}}
{{- define "livekit_server.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.livekit.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper cronjob image name
*/}}
{{- define "cronjob.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.cronjob.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "livekit_server.volumePermissions.image" -}}
{{- include "common.images.image" ( dict "imageRoot" "global" .Values.global ) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "livekit_server.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.livekit.image) "context" $) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "cronjob.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.cronjob.image) "context" $) -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "livekit_server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return true if cert-manager required annotations for TLS signed certificates are set in the Ingress annotations
Ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
*/}}
{{- define "livekit_server.ingress.certManagerRequest" -}}
{{ if or (hasKey . "cert-manager.io/cluster-issuer") (hasKey . "cert-manager.io/issuer") }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message.
*/}}
