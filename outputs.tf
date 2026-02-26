output "service" {
  description = "Outputs all attributes of service."
  value = {
    for service in keys(kubernetes_service.service) :
    service => {
      for key, value in kubernetes_service.service[service] :
      key => value
    }
  }
}

output "service_account" {
  description = "Outputs all attributes of service_account."
  value = {
    for service_account in keys(kubernetes_service_account.service_account) :
    service_account => {
      for key, value in kubernetes_service_account.service_account[service_account] :
      key => value
    }
  }
}

output "role_binding" {
  description = "Outputs all attributes of role_binding."
  value = {
    for role_binding in keys(kubernetes_role_binding.role_binding) :
    role_binding => {
      for key, value in kubernetes_role_binding.role_binding[role_binding] :
      key => value
    }
  }
}

output "cluster_role_binding" {
  description = "Outputs all attributes of cluster_role_binding."
  value = {
    for cluster_role_binding in keys(kubernetes_cluster_role_binding.cluster_role_binding) :
    cluster_role_binding => {
      for key, value in kubernetes_cluster_role_binding.cluster_role_binding[cluster_role_binding] :
      key => value
    }
  }
}

output "namespace" {
  description = "Outputs all attributes of namespace."
  value = {
    for namespace in keys(kubernetes_namespace.namespace) :
    namespace => {
      for key, value in kubernetes_namespace.namespace[namespace] :
      key => value
    }
  }
}

output "secret" {
  description = "Outputs all attributes of secret."
  value = {
    for secret in keys(kubernetes_secret.secret) :
    secret => {
      for key, value in kubernetes_secret.secret[secret] :
      key => value
    }
  }
  sensitive = true
}

output "config_map" {
  description = "Outputs all attributes of config_map."
  value = {
    for config_map in keys(kubernetes_config_map.config_map) :
    config_map => {
      for key, value in kubernetes_config_map.config_map[config_map] :
      key => value
    }
  }
}

output "storage_class" {
  description = "Outputs all attributes of storage_class."
  value = {
    for storage_class in keys(kubernetes_storage_class.storage_class) :
    storage_class => {
      for key, value in kubernetes_storage_class.storage_class[storage_class] :
      key => value
    }
  }
}

output "persistent_volume_claim" {
  description = "Outputs all attributes of persistent_volume_claim."
  value = {
    for persistent_volume_claim in keys(kubernetes_persistent_volume_claim.persistent_volume_claim) :
    persistent_volume_claim => {
      for key, value in kubernetes_persistent_volume_claim.persistent_volume_claim[persistent_volume_claim] :
      key => value
    }
  }
}

output "variables" {
  description = "Displays all configurable variables passed by the module. __default__ = predefined values per module. __merged__ = result of merging the default values and custom values passed to the module"
  value = {
    default = {
      for variable in keys(local.default) :
      variable => local.default[variable]
    }
    merged = {
      service = {
        for key in keys(var.service) :
        key => local.service[key]
      }
      service_account = {
        for key in keys(var.service_account) :
        key => local.service_account[key]
      }
      cluster_role_binding = {
        for key in keys(var.cluster_role_binding) :
        key => local.cluster_role_binding[key]
      }
      role_binding = {
        for key in keys(var.role_binding) :
        key => local.role_binding[key]
      }
      namespace = {
        for key in keys(var.namespace) :
        key => local.namespace[key]
      }
      secret = {
        for key in keys(var.secret) :
        key => local.secret[key]
      }
      config_map = {
        for key in keys(var.config_map) :
        key => local.config_map[key]
      }
      storage_class = {
        for key in keys(var.storage_class) :
        key => local.storage_class[key]
      }
      persistent_volume_claim = {
        for key in keys(var.persistent_volume_claim) :
        key => local.persistent_volume_claim[key]
      }
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
}
