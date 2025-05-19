package main

deny contains msg if {
  input.kind == "Deployment" or input.kind == "StatefulSet" or input.kind == "DaemonSet" or input.kind == "Job" or input.kind == "Pod"
  not input.spec.template.spec.securityContext.runAsNonRoot

  msg := "Containers must not run as root"
}

deny contains msg if {
  input.kind == "Deployment"
  not input.spec.selector.matchLabels.app

  msg := "Containers must provide app label for pod selectors"
}

#disallow latest tag
deny contains msg if {
  input.kind == "Deployment"
  input.spec.template.spec.containers[_].image == "latest"

  msg := "Containers must not use the latest tag"
}



# require tags
# require digest
# disallow default service account
