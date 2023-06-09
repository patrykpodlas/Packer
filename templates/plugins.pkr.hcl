packer {
  required_version = ">= 1.7.0"
  required_plugins {
    vsphere = {
      version = ">= v1.0.3"
      source  = "github.com/hashicorp/vsphere"
    }
  }
  required_plugins {
    windows-update = {
      version = ">= 0.14.0"
      source  = "github.com/rgl/windows-update"
    }
  }
}
