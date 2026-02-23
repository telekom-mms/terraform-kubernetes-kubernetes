variable "service" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "service_account" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "role_binding" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "cluster_role_binding" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "namespace" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "secret" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "config_map" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "storage_class" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "persistent_volume_claim" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

locals {
  default = {
    // resource definition
    service = {
      metadata = {
        name          = ""
        namespace     = null
        annotations   = null
        generate_name = null
        labels        = null
      }
      spec = {
        allocate_load_balancer_node_ports = null
        cluster_ip                        = null
        cluster_ips                       = null
        external_ips                      = null
        external_name                     = null
        external_traffic_policy           = null
        ip_families                       = null
        ip_family_policy                  = null
        internal_traffic_policy           = null
        load_balancer_class               = null
        load_balancer_ip                  = null
        load_balancer_source_ranges       = null
        publish_not_ready_addresses       = null
        selector                          = null
        type                              = null
        health_check_node_port            = null
        session_affinity                  = null
        port = {
          name         = ""
          app_protocol = null
          node_port    = null
          protocol     = "TCP" // defined default
          target_port  = null
        }
        session_affinity_config = {
          client_ip = {
            timeout_seconds = null
          }
        }
      }
      wait_for_load_balancer = null
    }
    service_account = {
      metadata = {
        name          = ""
        namespace     = "kube-system" // defined default
        annotations   = null
        generate_name = null
        labels        = null
      }
      automount_service_account_token = null
    }
    cluster_role_binding = {
      metadata = {
        name          = ""
        annotations   = null
        generate_name = null
        labels        = null
      }
      role_ref = {
        kind      = "ClusterRole"               // defined default
        api_group = "rbac.authorization.k8s.io" // defined default
      }
      subject = {
        name      = ""
        namespace = null
        kind      = "ServiceAccount" // defined default
        api_group = null
      }
    }
    role_binding = {
      metadata = {
        name          = ""
        annotations   = null
        generate_name = null
        labels        = null
      }
      role_ref = {
        kind      = "ClusterRole"               // defined default
        api_group = "rbac.authorization.k8s.io" // defined default
      }
      subject = {
        name      = ""
        namespace = null
        kind      = "ServiceAccount"            // defined default
        api_group = "rbac.authorization.k8s.io" // defined default
      }
    }
    namespace = {
      metadata = {
        name          = ""
        annotations   = null
        generate_name = null
        labels        = null
      }
    }
    secret = {
      metadata = {
        name          = ""
        namespace     = null
        annotations   = null
        generate_name = null
        labels        = null
      }
      data        = null
      binary_data = null
      type        = null
      immutable   = null
    }
    config_map = {
      metadata = {
        name          = ""
        namespace     = null
        annotations   = null
        generate_name = null
        labels        = null
      }
      data        = null
      binary_data = null
    }
    storage_class = {
      metadata = {
        name          = ""
        annotations   = null
        generate_name = null
        labels        = null
      }
      parameters             = null
      storage_provisioner    = null
      reclaim_policy         = null
      volume_binding_mode    = null
      allow_volume_expansion = null
      mount_options          = null
      allowed_topologies = {
        match_label_expressions = {}
      }
    }
    persistent_volume_claim = {
      metadata = {
        name          = ""
        namespace     = null
        annotations   = null
        generate_name = null
        labels        = null
      }
      spec = {
        volume_name        = null
        storage_class_name = null
        resources = {
          limits   = null
          requests = null
        }
        selector = {
          match_expressions = {
            key      = null
            operator = null
            values   = null
          }
          match_labels = null
        }
      }
      wait_until_bound = null
    }
  }

  // compare and merge custom and default values
  service_values = {
    for service in keys(var.service) :
    service => merge(local.default.service, var.service[service])
  }
  service_account_values = {
    for service_account in keys(var.service_account) :
    service_account => merge(local.default.service_account, var.service_account[service_account])
  }
  role_binding_values = {
    for role_binding in keys(var.role_binding) :
    role_binding => merge(local.default.role_binding, var.role_binding[role_binding])
  }
  cluster_role_binding_values = {
    for cluster_role_binding in keys(var.cluster_role_binding) :
    cluster_role_binding => merge(local.default.cluster_role_binding, var.cluster_role_binding[cluster_role_binding])
  }
  namespace_values = {
    for namespace in keys(var.namespace) :
    namespace => merge(local.default.namespace, var.namespace[namespace])
  }
  secret_values = {
    for secret in keys(var.secret) :
    secret => merge(local.default.secret, var.secret[secret])
  }
  config_map_values = {
    for config_map in keys(var.config_map) :
    config_map => merge(local.default.config_map, var.config_map[config_map])
  }
  storage_class_values = {
    for storage_class in keys(var.storage_class) :
    storage_class => merge(local.default.storage_class, var.storage_class[storage_class])
  }
  persistent_volume_claim_values = {
    for persistent_volume_claim in keys(var.persistent_volume_claim) :
    persistent_volume_claim => merge(local.default.persistent_volume_claim, var.persistent_volume_claim[persistent_volume_claim])
  }

  // deep merge of all custom and default values
  service = {
    for service in keys(var.service) :
    service => merge(
      local.service_values[service],
      {
        for config in ["metadata"] :
        config => merge(local.default.service[config], local.service_values[service][config])
      },
      {
        for config in ["spec"] :
        config => merge(
          merge(local.default.service[config], local.service_values[service][config]),
          {
            for subconfig in ["session_affinity_config"] :
            subconfig => merge(
              local.default.service[config][subconfig],
              merge(local.default.service[config], local.service_values[service][config])[subconfig]
            )
          },
          {
            for subconfig in ["port"] :
            subconfig => {
              for key in keys(local.service_values[service][config][subconfig]) :
              key => merge(
                local.default.service[config][subconfig],
                merge(local.default.service[config], local.service_values[service][config])[subconfig][key]
              )
            }
          }
        )
      }
    )
  }
  service_account = {
    for service_account in keys(var.service_account) :
    service_account => merge(
      local.service_account_values[service_account],
      {
        for config in ["metadata"] :
        config => merge(local.default.service_account[config], local.service_account_values[service_account][config])
      }
    )
  }
  role_binding = {
    for role_binding in keys(var.role_binding) :
    role_binding => merge(
      local.role_binding_values[role_binding],
      {
        for config in ["metadata", "role_ref"] :
        config => merge(local.default.role_binding[config], local.role_binding_values[role_binding][config])
      },
      {
        for config in ["subject"] :
        config => {
          for key in keys(local.role_binding_values[role_binding][config]) :
          key => merge(local.default.role_binding[config], local.role_binding_values[role_binding][config][key])
        }
      }
    )
  }
  cluster_role_binding = {
    for cluster_role_binding in keys(var.cluster_role_binding) :
    cluster_role_binding => merge(
      local.cluster_role_binding_values[cluster_role_binding],
      {
        for config in ["metadata", "role_ref"] :
        config => merge(local.default.cluster_role_binding[config], local.cluster_role_binding_values[cluster_role_binding][config])
      },
      {
        for config in ["subject"] :
        config => {
          for key in keys(local.cluster_role_binding_values[cluster_role_binding][config]) :
          key => merge(local.default.cluster_role_binding[config], local.cluster_role_binding_values[cluster_role_binding][config][key])
        }
      }
    )
  }
  namespace = {
    for namespace in keys(var.namespace) :
    namespace => merge(
      local.namespace_values[namespace],
      {
        for config in ["metadata"] :
        config => merge(local.default.namespace[config], local.namespace_values[namespace][config])
      }
    )
  }
  secret = {
    for secret in keys(var.secret) :
    secret => merge(
      local.secret_values[secret],
      {
        for config in ["metadata"] :
        config => merge(local.default.secret[config], local.secret_values[secret][config])
      }
    )
  }
  config_map = {
    for config_map in keys(var.config_map) :
    config_map => merge(
      local.config_map_values[config_map],
      {
        for config in ["metadata"] :
        config => merge(local.default.config_map[config], local.config_map_values[config_map][config])
      }
    )
  }
  storage_class = {
    for storage_class in keys(var.storage_class) :
    storage_class => merge(
      local.storage_class_values[storage_class],
      {
        for config in ["metadata"] :
        config => merge(local.default.storage_class[config], local.storage_class_values[storage_class][config])
      }
    )
  }
  persistent_volume_claim = {
    for persistent_volume_claim in keys(var.persistent_volume_claim) :
    persistent_volume_claim => merge(
      local.persistent_volume_claim_values[persistent_volume_claim],
      {
        for config in ["metadata"] :
        config => merge(local.default.persistent_volume_claim[config], local.persistent_volume_claim_values[persistent_volume_claim][config])
      },
      {
        for config in ["spec"] :
        config => merge(
          local.default.persistent_volume_claim[config],
          local.persistent_volume_claim_values[persistent_volume_claim][config],
          {
            resources = merge(
              local.default.persistent_volume_claim[config].resources, local.persistent_volume_claim_values[persistent_volume_claim][config].resources
            )
          }
        )
      }
    )
  }
}
