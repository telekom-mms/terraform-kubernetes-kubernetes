module "kubernetes" {
  source = "../"

  service = {
    svcmms = {
      metadata = {
        namespace = "default"
        labels = {
          app = "mms-example"
        }
      }
      spec = {
        type = "NodePort"
        selector = {
          app = "mms-example"
        }
        port = {
          http = {
            port        = 80
            target_port = 8080
            node_port   = 30080
            protocol    = "TCP"
          }
        }
      }
    }
  }

  service_account = {
    samms = {
      metadata = {
        namespace = "default"
        labels = {
          app = "mms-example"
        }
        annotations = {
          "serviceaccount.name" = "samms"
        }
      }
      automount_service_account_token = true
    }
  }

  role_binding = {
    rbmms = {
      metadata = {
        namespace = "default"
        labels = {
          app = "mms-example"
        }
      }
      role_ref = {
        name      = "cluster-admin"
        kind      = "ClusterRole"
        api_group = "rbac.authorization.k8s.io"
      }
      subject = {
        submms = {
          name      = "default"
          namespace = "default"
          kind      = "ServiceAccount"
          api_group = ""
        }
      }
    }
  }

  cluster_role_binding = {
    crbmms = {
      metadata = {
        labels = {
          app = "mms-example"
        }
      }
      role_ref = {
        name      = "cluster-admin"
        kind      = "ClusterRole"
        api_group = "rbac.authorization.k8s.io"
      }
      subject = {
        submms = {
          name      = "default"
          namespace = "default"
          kind      = "ServiceAccount"
          api_group = ""
        }
      }
    }
  }

  namespace = {
    nsmms = {
      metadata = {
        labels = {
          name = "nsmms"
          env  = "example"
        }
        annotations = {
          "managed-by" = "terraform"
        }
      }
    }
  }

  secret = {
    secmms = {
      metadata = {
        namespace = "default"
        labels = {
          app = "mms-example"
        }
      }
      type = "Opaque"
      data = {
        username = "admin"
        password = "changeme"
      }
    }
  }

  config_map = {
    cmmms = {
      metadata = {
        namespace = "default"
        labels = {
          app = "mms-example"
        }
      }
      data = {
        "config.yaml"   = "debug: true\nlogLevel: info"
        "ui.properties" = "color=blue"
      }
    }
  }

  storage_class = {
    scmms = {
      metadata = {
        labels = {
          env = "example"
        }
      }
      storage_provisioner = "kubernetes.io/no-provisioner"
      reclaim_policy      = "Delete"
      parameters = {
        type = "pd-standard"
      }
    }
  }

  persistent_volume_claim = {
    pvcmms = {
      metadata = {
        namespace = "default"
        labels = {
          app = "mms-example"
        }
      }
      spec = {
        access_modes       = ["ReadWriteOnce"]
        storage_class_name = "standard"
        resources = {
          requests = {
            storage = "5Gi"
          }
        }
      }
    }
  }
}
