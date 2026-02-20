module "kubernetes" {
  source = "registry.terraform.io/telekom-mms/kubernetes/kubernetes"

  service = {
    svcmms = {
      spec = {
        port = {
          http = {
            port = 80
          }
        }
      }
    }
  }

  service_account = {
    samms = {}
  }

  role_binding = {
    rbmms = {
      role_ref = {
        name = "cluster-admin"
      }
      subject = {
        submms = {
          name      = "default"
          namespace = "default"
          api_group = ""
        }
      }
    }
  }

  cluster_role_binding = {
    crbmms = {
      role_ref = {
        name = "cluster-admin"
      }
      subject = {
        submms = {
          name      = "default"
          namespace = "default"
          api_group = ""
        }
      }
    }
  }

  namespace = {
    nsmms = {}
  }

  secret = {
    secmms = {}
  }

  config_map = {
    cmmms = {}
  }

  storage_class = {
    scmms = {
      storage_provisioner = "kubernetes.io/no-provisioner"
    }
  }

  persistent_volume_claim = {
    pvcmms = {
      spec = {
        access_modes = ["ReadWriteOnce"]
        resources = {
          requests = {
            storage = "1Gi"
          }
        }
      }
    }
  }
}
