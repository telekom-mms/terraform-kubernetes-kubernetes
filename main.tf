/**
 * # kubernetes
 *
 * This module manages the kubernetes kubernetes resources, see https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs.
 *
 * For more information about the module structure see https://telekom-mms.github.io/terraform-template.
 *
*/

resource "kubernetes_service" "service" {
  for_each = var.service

  metadata {
    name          = local.service[each.key].metadata.name == "" ? each.key : local.service[each.key].metadata.name
    namespace     = local.service[each.key].metadata.namespace
    annotations   = local.service[each.key].metadata.annotations
    generate_name = local.service[each.key].metadata.generate_name
    labels        = local.service[each.key].metadata.labels
  }
  spec {
    allocate_load_balancer_node_ports   = local.service[each.key].spec.allocate_load_balancer_node_ports
    cluster_ip                          = local.service[each.key].spec.cluster_ip
    cluster_ips                         = local.service[each.key].spec.cluster_ips
    external_ips                        = local.service[each.key].spec.external_ips
    external_name                       = local.service[each.key].spec.external_name
    external_traffic_policy             = local.service[each.key].spec.external_traffic_policy
    ip_families                         = local.service[each.key].spec.ip_families
    ip_family_policy                   = local.service[each.key].spec.ip_family_policy
    internal_traffic_policy             = local.service[each.key].spec.internal_traffic_policy
    load_balancer_class                 = local.service[each.key].spec.load_balancer_class
    load_balancer_ip                    = local.service[each.key].spec.load_balancer_ip
    load_balancer_source_ranges         = local.service[each.key].spec.load_balancer_source_ranges
    publish_not_ready_addresses         = local.service[each.key].spec.publish_not_ready_addresses
    selector                            = local.service[each.key].spec.selector
    type                               = local.service[each.key].spec.type
    health_check_node_port              = local.service[each.key].spec.health_check_node_port
    session_affinity                   = local.service[each.key].spec.session_affinity

    dynamic "port" {
      for_each = local.service[each.key].spec.port

      content {
        name = local.service[each.key].spec.port[port.key].name == "" ? port.key : local.service[each.key].spec.port[port.key].name
        app_protocol = local.service[each.key].spec.port[port.key].app_protocol
        node_port    = local.service[each.key].spec.port[port.key].node_port
        port         = local.service[each.key].spec.port[port.key].port
        protocol     = local.service[each.key].spec.port[port.key].protocol
        target_port  = local.service[each.key].spec.port[port.key].target_port
      }
    }

    dynamic "session_affinity_config" {
      for_each = local.service[each.key].spec.session_affinity_config.client_ip.timeout_seconds != null ? [1] : []

      content {
        client_ip {
          timeout_seconds = local.service[each.key].spec.session_affinity_config.client_ip.timeout_seconds
        }
      }
    }
  }
  wait_for_load_balancer = local.service[each.key].wait_for_load_balancer
}

resource "kubernetes_service_account" "service_account" {
  for_each = var.service_account

  metadata {
    name          = local.service_account[each.key].metadata.name == "" ? each.key : local.service_account[each.key].metadata.name
    namespace     = local.service_account[each.key].metadata.namespace
    annotations   = local.service_account[each.key].metadata.annotations
    generate_name = local.service_account[each.key].metadata.generate_name
    labels        = local.service_account[each.key].metadata.labels
  }
  automount_service_account_token = local.service_account[each.key].automount_service_account_token
}

resource "kubernetes_cluster_role_binding" "cluster_role_binding" {
  for_each = var.cluster_role_binding

  metadata {
    name = local.cluster_role_binding[each.key].metadata.name == "" ? each.key : local.cluster_role_binding[each.key].metadata.name
    annotations   = local.cluster_role_binding[each.key].metadata.annotations
    #generate_name = local.cluster_role_binding[each.key].metadata.generate_name
    labels        = local.cluster_role_binding[each.key].metadata.labels
  }

  role_ref {
    name      = local.cluster_role_binding[each.key].role_ref.name
    kind      = local.cluster_role_binding[each.key].role_ref.kind
    api_group = local.cluster_role_binding[each.key].role_ref.api_group
  }

  dynamic "subject" {
    for_each = local.cluster_role_binding[each.key].subject

    content {
      name      = local.cluster_role_binding[each.key].subject[subject.key].name == "" ? each.key : local.cluster_role_binding[each.key].subject[subject.key].name
      namespace = local.cluster_role_binding[each.key].subject[subject.key].namespace
      kind      = local.cluster_role_binding[each.key].subject[subject.key].kind
      api_group = local.cluster_role_binding[each.key].subject[subject.key].api_group
    }
  }
}

resource "kubernetes_role_binding" "role_binding" {
  for_each = var.role_binding

  metadata {
    name = local.role_binding[each.key].metadata.name == "" ? each.key : local.role_binding[each.key].metadata.name
    namespace = local.role_binding[each.key].metadata.namespace
    annotations   = local.role_binding[each.key].metadata.annotations
    #generate_name = local.role_binding[each.key].metadata.generate_name
    labels        = local.role_binding[each.key].metadata.labels
  }

  role_ref {
    name      = local.role_binding[each.key].role_ref.name
    kind      = local.role_binding[each.key].role_ref.kind
    api_group = local.role_binding[each.key].role_ref.api_group
  }

  dynamic "subject" {
    for_each = local.role_binding[each.key].subject

    content {
      name      = local.role_binding[each.key].subject[subject.key].name == "" ? each.key : local.role_binding[each.key].subject[subject.key].name
      namespace = local.role_binding[each.key].subject[subject.key].namespace
      kind      = local.role_binding[each.key].subject[subject.key].kind
      api_group = local.role_binding[each.key].subject[subject.key].api_group
    }
  }
}

resource "kubernetes_namespace" "namespace" {
  for_each = var.namespace

  metadata {
    name          = local.namespace[each.key].metadata.name == "" ? each.key : local.namespace[each.key].metadata.name
    annotations   = local.namespace[each.key].metadata.annotations
    generate_name = local.namespace[each.key].metadata.generate_name
    labels        = local.namespace[each.key].metadata.labels
  }
}

resource "kubernetes_secret" "secret" {
  for_each = var.secret

  metadata {
    name          = local.secret[each.key].metadata.name == "" ? each.key : local.secret[each.key].metadata.name
    namespace     = local.secret[each.key].metadata.namespace
    annotations   = local.secret[each.key].metadata.annotations
    generate_name = local.secret[each.key].metadata.generate_name
    labels        = local.secret[each.key].metadata.labels
  }

  data        = local.secret[each.key].data
  binary_data = local.secret[each.key].binary_data
  type        = local.secret[each.key].type
  immutable   = local.secret[each.key].immutable
}

resource "kubernetes_config_map" "config_map" {
  for_each = var.config_map

  metadata {
    name          = local.config_map[each.key].metadata.name == "" ? each.key : local.config_map[each.key].metadata.name
    namespace     = local.config_map[each.key].metadata.namespace
    annotations   = local.config_map[each.key].metadata.annotations
    generate_name = local.config_map[each.key].metadata.generate_name
    labels        = local.config_map[each.key].metadata.labels
  }

  data        = local.config_map[each.key].data
  binary_data = local.config_map[each.key].binary_data
}

resource "kubernetes_storage_class" "storage_class" {
  for_each = var.storage_class

  metadata {
    name          = local.storage_class[each.key].metadata.name == "" ? each.key : local.storage_class[each.key].metadata.name
    annotations   = local.storage_class[each.key].metadata.annotations
    generate_name = local.storage_class[each.key].metadata.generate_name
    labels        = local.storage_class[each.key].metadata.labels
  }

  parameters = local.storage_class[each.key].parameters
  storage_provisioner = local.storage_class[each.key].storage_provisioner
  reclaim_policy = local.storage_class[each.key].reclaim_policy
  volume_binding_mode  = local.storage_class[each.key].volume_binding_mode
  allow_volume_expansion  = local.storage_class[each.key].allow_volume_expansion
  mount_options = local.storage_class[each.key].mount_options

  dynamic "allowed_topologies" {
    for_each = local.storage_class[each.key].allowed_topologies.match_label_expressions != {} ? [1] : []

    content {
      dynamic "match_label_expressions" {
        for_each = local.storage_class[each.key].allowed_topologies.match_label_expressions

        content {
          key    = local.storage_class[each.key].allowed_topologies.match_label_expressions[each.key]
          values = local.storage_class[each.key].allowed_topologies.match_label_expressions[each.value]
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "persistent_volume_claim" {
  for_each = var.persistent_volume_claim

  metadata {
    name          = local.persistent_volume_claim[each.key].metadata.name == "" ? each.key : local.persistent_volume_claim[each.key].metadata.name
    namespace  = local.persistent_volume_claim[each.key].metadata.namespace
    annotations   = local.persistent_volume_claim[each.key].metadata.annotations
    generate_name = local.persistent_volume_claim[each.key].metadata.generate_name
    labels        = local.persistent_volume_claim[each.key].metadata.labels
  }

  spec {
    access_modes   = local.persistent_volume_claim[each.key].spec.access_modes
    volume_name  = local.persistent_volume_claim[each.key].spec.volume_name
    storage_class_name = local.persistent_volume_claim[each.key].spec.storage_class_name

    resources {
      limits = local.persistent_volume_claim[each.key].spec.resources.limits
      requests = local.persistent_volume_claim[each.key].spec.resources.requests
    }

    dynamic "selector" {
      for_each = compact([
        local.persistent_volume_claim[each.key].spec.selector.match_labels,
        local.persistent_volume_claim[each.key].spec.selector.match_expressions.key,
        local.persistent_volume_claim[each.key].spec.selector.match_expressions.operator,
        local.persistent_volume_claim[each.key].spec.selector.match_expressions.values
      ])

      content {
        match_labels = local.persistent_volume_claim[each.key].spec.selector.match_labels

        match_expressions {
          key = local.persistent_volume_claim[each.key].spec.selector.match_expressions.key
          operator = local.persistent_volume_claim[each.key].spec.selector.match_expressions.operator
          values = local.persistent_volume_claim[each.key].spec.selector.match_expressions.values
        }
      }
    }
  }
  wait_until_bound =  local.persistent_volume_claim[each.key].wait_until_bound
}
