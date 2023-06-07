// vCenter Server Settings and Credentials
variable "default_vsphere_server" {
  type        = string
  default     = "vcsa-001-p-p.podlas.local"
  description = "vCenter server FQDN."
}
variable "env_vsphere_username" {
  type        = string
  sensitive   = true
  description = "User with permissions to create VM's and import to the content library."
  default     = ""
}
variable "env_vsphere_password" {
  type        = string
  sensitive   = true
  description = "Password for vSphere_User"
  default     = ""
}
variable "default_insecure_connection" {
  type        = bool
  default     = true
  description = "Requires the target vCenter Server to have a valid, trusted certificate."
}
variable "env_vsphere_scripts_username" {
  type      = string
  default   = ""
  sensitive = true
}
variable "env_vsphere_scripts_password" {
  type      = string
  default   = ""
  sensitive = true
}

// vSphere Settings
variable "default_vsphere_compute_cluster" {
  type        = string
  default     = "CL-01"
  description = "Target Cluster for the deployment."
}
variable "default_vsphere_datacenter" {
  type        = string
  default     = "Home"
  description = "Target Datacenter for the deploymen."
}
variable "default_vsphere_datastore" {
  type        = string
  default     = "DS-LK-ESXI-001-HashiCorp-Templates"
  description = "Target Datacenter for the deployment."
}
variable "default_vsphere_folder" {
  type        = string
  default     = "_Templates"
  description = "Folder that the VM will temporarily be storaged in before upload to the content library."
}

// VM Settings
variable "default_CPUs" {
  type        = string
  default     = "2"
  description = "Amount of vCPU's that are to be allocated to the template."
}
variable "default_RAM" {
  type        = string
  default     = "4096"
  description = "Amount of memory to be allocated to the template."
}
variable "default_firmware" {
  type        = string
  default     = "efi"
  description = "Firmware for the template.  Windows OS's should use EFI.."
}
variable "default_vm_version" {
  type        = string
  default     = "18"
  description = "VM Hardware Version."
}
variable "vm_guest_os_type" {
  type        = string
  description = "Version of the guest operating system."
}
variable "default_vsphere_portgroup_name" {
  type        = string
  default     = "vDPG-WK-92-MGMT-1964-Management"
  description = "Target Portgroup for the deployment."
}
variable "default_network_card" {
  type        = string
  default     = "vmxnet3"
  description = "Virtual NIC type."
}
variable "default_disk_controller_type" {
  type        = list(string)
  default     = ["pvscsi"]
  description = "VM disk controller type."
}
variable "default_disk_size" {
  type        = string
  default     = "51200"
  description = "Size of the OS disk in MB."
}
variable "default_disk_thin_provisioned" {
  type        = bool
  default     = true
  description = "Create a thin provisioned disk by default."
}
variable "default_remove_cdrom" {
  type        = bool
  default     = true
  description = "Removed the CDROM drives from the template."
}

//Boot & Shutdown Settings
variable "default_boot_command" {
  type        = list(string)
  default     = ["<spacebar>"]
  description = "Boot command key strokes to be sent to the VM."
}
variable "default_boot_order" {
  type    = string
  default = "disk,cdrom"
}
variable "default_boot_wait" {
  type        = string
  default     = "3s"
  description = "Delay in seconds for when Packer should begin sending the boot command key strokes."
}
variable "default_shutdown_timeout" {
  type        = string
  default     = "30m"
  description = "Time in minutes Packer should wait for the virtual machine to shutdown."
}
variable "default_shutdown_command" {
  type        = string
  default     = "C:\\Windows\\system32\\sysprep\\sysprep.exe /quiet /generalize /oobe /shutdown\""
  description = "Shutdown command."
}

//Media Settings
variable "vm_inst_os_iso_path" {
  type        = string
  description = "Path to the OS ISO file including the datastore name."
}
variable "vm_inst_vmtools_iso_path" {
  type        = string
  description = "Path to the VMware Tools ISO file including the datastore name."
}
variable "vm_inst_os_language" {
  type        = string
  description = "OS UI language."
}
variable "vm_inst_os_keyboard" {
  type        = string
  description = "OS Keyboard language."
}
variable "vm_inst_os_image_standard_core" {
  type        = string
  description = "OS identifier."
}
variable "vm_inst_os_image_standard_desktop" {
  type        = string
  description = "OS identifier."
}
variable "vm_inst_os_kms_key_standard" {
  type        = string
  description = "OS Key."
}
variable "vm_inst_os_image_datacenter_core" {
  type        = string
  description = "OS identifier."
}
variable "vm_inst_os_image_datacenter_desktop" {
  type        = string
  description = "OS identifier."
}
variable "vm_inst_os_kms_key_datacenter" {
  type        = string
  description = "OS Key."
}
variable "vm_inst_http_directory" {
  type        = string
  default     = "E:\\media"
  description = "Path to software installation media."
}
variable "vm_inst_http_port_max" {
  type        = number
  default     = 8000
  description = "Limits the maximum dynamic port number Packer uses for its HTTP server."
}


// Guest Operating System Metadata
variable "vm_guest_os_language" {
  type        = string
  description = "OS UI language."
}
variable "vm_guest_os_keyboard" {
  type        = string
  description = "OS Keyboard language."
}
variable "vm_guest_os_timezone" {
  type        = string
  description = "Time Zone."
}
variable "vm_guest_os_family" {
  type        = string
  description = "OS Family E.g windows."
}
variable "vm_guest_os_name" {
  type        = string
  description = "OS Name E.g server."
}
variable "vm_guest_os_version" {
  type        = string
  description = "OS Key."
}
variable "vm_guest_os_edition_standard" {
  type        = string
  description = "Standard Edition."
}
variable "vm_guest_os_edition_datacenter" {
  type        = string
  description = "Datacenter Edition."
}
variable "vm_guest_os_experience_core" {
  type        = string
  description = "Core Experience."
}
variable "vm_guest_os_experience_desktop" {
  type        = string
  description = "Desktop Experience."
}

// Communicator Settings
variable "default_communicator" {
  type        = string
  default     = "winrm"
  description = "WinRM or SSH depending on the OS you are connecting to."
}
variable "default_winrm_insecure" {
  type        = bool
  default     = true
  description = "WinRM to check the certificate is valid or not."
}
variable "default_communicator_use_ssl" {
  type        = bool
  default     = true
  description = "Use SSL by default."
}
variable "env_communicator_username" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Used by Packer to connect to the virtual machine over WinRM."
}
variable "env_communicator_password" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Used by Packer to connect to the virtual machine over WinRM."
}
variable "default_communicator_timeout" {
  type        = string
  default     = "30m"
  description = "Timeout value for how long Packer should wait for WinRM to become available once an IP has been assigned, this should be set to as low as possible to aid troubleshooting."
}

// Content Library Settings
variable "default_content_library_destination" {
  type        = string
  default     = "Packer Templates"
  description = "Name of the content library the template will be uploaded to."
}
variable "default_library_vm_destroy" {
  type        = bool
  default     = true
  description = "Destroys the original VM template from the inventory once its has been uploaded to the content library."
}
variable "default_ovf" {
  type        = bool
  default     = true
  description = "Template will be uploaded to the content library in the OVF format."
}
