terraform {
  required_providers {
    ionoscloud = {
      source = "ionos-cloud/ionoscloud"
      version = " 6.3.0"
    }
  }
}

provider "ionoscloud" {
  username = "ITOAH20230907_CLOUD_MURIZAL@itohm.de"
  password = "Blossoms1972"
}

resource "ionoscloud_datacenter" "rizwan_ionos_dc" {
  name                  = "rizwan_ionos_dc"
  location              = "de/txl"
  description           = "Datacenter for Task"
  sec_auth_protection   = false
}

resource "ionoscloud_k8s_cluster" "ionos_k8s" {
  name                  = "ionos_k8s"
  k8s_version           = "1.27.4"
  maintenance_window {
    day_of_the_week     = "Sunday"
    time                = "09:00:00Z"
  }
}

resource "ionoscloud_k8s_node_pool" "k8sNodePool_ionos" {
  datacenter_id         = ionoscloud_datacenter.rizwan_ionos_dc.id
  k8s_cluster_id        = ionoscloud_k8s_cluster.ionos_k8s.id
  name                  = "k8sNodePool_ionos"
  k8s_version           = ionoscloud_k8s_cluster.ionos_k8s.k8s_version
  maintenance_window {
    day_of_the_week     = "Monday"
    time                = "09:00:00Z"
  } 
  auto_scaling {
    min_node_count      = 1
    max_node_count      = 3
  }
  cpu_family            = "INTEL_SKYLAKE"
  availability_zone     = "AUTO"
  storage_type          = "SSD"
  node_count            = 2
  cores_count           = 2
  ram_size              = 4096
  storage_size          = 40
}  



