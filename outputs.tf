output "service" {
  description = "Outputs all attributes of service."
  value = {
    for k in keys(kubernetes_service.service) :
    k => {
      for key, value in kubernetes_service.service[k] :
      key => value
    }
  }
}

output "service_account" {
  description = "Outputs all attributes of service_account."
  value = {
    for k in keys(kubernetes_service_account.service_account) :
    k => {
      for key, value in kubernetes_service_account.service_account[k] :
      key => value
    }
  }
}

output "role_binding" {
  description = "Outputs all attributes of role_binding."
  value = {
    for k in keys(kubernetes_role_binding.role_binding) :
    k => {
      for key, value in kubernetes_role_binding.role_binding[k] :
      key => value
    }
  }
}

output "cluster_role_binding" {
  description = "Outputs all attributes of cluster_role_binding."
  value = {
    for k in keys(kubernetes_cluster_role_binding.cluster_role_binding) :
    k => {
      for key, value in kubernetes_cluster_role_binding.cluster_role_binding[k] :
      key => value
    }
  }
}

output "namespace" {
  description = "Outputs all attributes of namespace."
  value = {
    for k in keys(kubernetes_namespace.namespace) :
    k => {
      for key, value in kubernetes_namespace.namespace[k] :
      key => value
    }
  }
}

output "secret" {
  description = "Outputs all attributes of secret."
  value = {
    for k in keys(kubernetes_secret.secret) :
    k => {
      for key, value in kubernetes_secret.secret[k] :
      key => value
    }
  }
  sensitive = true
}

output "config_map" {
  description = "Outputs all attributes of config_map."
  value = {
    for k in keys(kubernetes_config_map.config_map) :
    k => {
      for key, value in kubernetes_config_map.config_map[k] :
      key => value
    }
  }
}

output "storage_class" {
  description = "Outputs all attributes of storage_class."
  value = {
    for k in keys(kubernetes_storage_class.storage_class) :
    k => {
      for key, value in kubernetes_storage_class.storage_class[k] :
      key => value
    }
  }
}

output "persistent_volume_claim" {
  description = "Outputs all attributes of persistent_volume_claim."
  value = {
    for k in keys(kubernetes_persistent_volume_claim.persistent_volume_claim) :
    k => {
      for key, value in kubernetes_persistent_volume_claim.persistent_volume_claim[k] :
      key => value
    }
  }
}

output "variables" {
  description = "Outputs all merged variables."
  value = {
    default = local.default
    merged = {
      service                 = local.service
      service_account         = local.service_account
      role_binding            = local.role_binding
      cluster_role_binding    = local.cluster_role_binding
      namespace               = local.namespace
      secret                  = local.secret
      config_map              = local.config_map
      storage_class           = local.storage_class
      persistent_volume_claim = local.persistent_volume_claim
    }
  }
  sensitive = true
}
