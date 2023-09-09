terraform {
  required_providers {
    ionoscloud = {
      source = "ionos-cloud/ionoscloud"
      version = " 6.3.0"
    }
  }
}

provider "ionoscloud" {
  username = var.username
  password = var.password
}

resource "ionoscloud_datacenter" "Task_ionos_dc" {
  name                  = "Task_ionos_dc"
  location              = "de/txl"
  description           = "DC for Task-1"
  sec_auth_protection   = false
}

resource "ionoscloud_k8s_cluster" "ionos_kube" {
  name                  = "ionos_kube"
  k8s_version           = "1.27.4"
  maintenance_window {
    day_of_the_week     = "Sunday"
    time                = "09:00:00Z"
  }
}

resource "ionoscloud_k8s_node_pool" "ionos_nodepool_1" {
  datacenter_id         = ionoscloud_datacenter.Task_ionos_dc.id
  k8s_cluster_id        = ionoscloud_k8s_cluster.ionos_kube.id
  name                  = "ionos_nodepool_1"
  k8s_version           = ionoscloud_k8s_cluster.ionos_kube.k8s_version
  maintenance_window {
    day_of_the_week     = "Monday"
    time                = "09:00:00Z"
  } 
  auto_scaling {
    min_node_count      = 1
    max_node_count      = 2
  }
  cpu_family            = "INTEL_SKYLAKE"
  availability_zone     = "AUTO"
  storage_type          = "SSD"
  node_count            = 2
  cores_count           = 2
  ram_size              = 4096
  storage_size          = 20
}  



