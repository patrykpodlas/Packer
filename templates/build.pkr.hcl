source "vsphere-iso" "windows_server_2019_standard_desktop_experience" {

  // vCenter Server Settings and Credentials
  vcenter_server      = var.default_vsphere_server
  username            = var.env_vsphere_username
  password            = var.env_vsphere_password
  insecure_connection = var.default_insecure_connection

  // vSphere Settings
  cluster    = var.default_vsphere_compute_cluster
  datacenter = var.default_vsphere_datacenter
  datastore  = var.default_vsphere_datastore
  folder     = var.default_vsphere_folder

  // VM Settings
  vm_name       = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${var.vm_guest_os_edition_standard}-${var.vm_guest_os_experience_desktop}"
  CPUs          = var.default_CPUs
  RAM           = var.default_RAM
  firmware      = var.default_firmware
  vm_version    = var.default_vm_version
  guest_os_type = var.vm_guest_os_type
  remove_cdrom  = var.default_remove_cdrom

  network_adapters {
    network      = var.default_vsphere_portgroup_name
    network_card = var.default_network_card
  }
  disk_controller_type = var.default_disk_controller_type
  storage {
    disk_size             = var.default_disk_size
    disk_thin_provisioned = var.default_disk_thin_provisioned
  }

  // Boot & Shutdown Settings
  boot_command     = var.default_boot_command
  boot_order       = var.default_boot_order
  boot_wait        = var.default_boot_wait
  shutdown_timeout = var.default_shutdown_timeout

  // Media Settings
  iso_paths = [var.vm_inst_os_iso_path, var.vm_inst_vmtools_iso_path]
  cd_files = [
    "${path.cwd}/scripts/${var.vm_guest_os_family}/enable_winrm.ps1"
  ]
  cd_content = {
    "autounattend.xml" = templatefile("${abspath(path.root)}/config/windows/autounattend.pkrtpl.hcl", {
      env_communicator_username = var.env_communicator_username
      env_communicator_password = var.env_communicator_password
      vm_inst_os_language       = var.vm_inst_os_language
      vm_inst_os_keyboard       = var.vm_inst_os_keyboard
      vm_inst_os_image          = var.vm_inst_os_image_standard_desktop
      vm_inst_os_kms_key        = var.vm_inst_os_kms_key_standard
      vm_guest_os_language      = var.vm_guest_os_language
      vm_guest_os_keyboard      = var.vm_guest_os_keyboard
      vm_guest_os_timezone      = var.vm_guest_os_timezone
    })

  }

  http_directory = var.vm_inst_http_directory
  http_port_max  = var.vm_inst_http_port_max

  // Communicator Settings
  communicator   = var.default_communicator
  winrm_insecure = var.default_winrm_insecure
  winrm_use_ssl  = var.default_communicator_use_ssl
  winrm_username = var.env_communicator_username
  winrm_password = var.env_communicator_password
  winrm_timeout  = var.default_communicator_timeout


  // Content Library Settings
  content_library_destination {
    name    = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${var.vm_guest_os_edition_standard}-${var.vm_guest_os_experience_desktop}"
    library = var.default_content_library_destination
    destroy = var.default_library_vm_destroy
    ovf     = var.default_ovf
  }
}
# windows_server_2019_standard_desktop_experience
build {
  sources = ["source.vsphere-iso.windows_server_2019_standard_desktop_experience"]
  provisioner "powershell" {
    inline = [
      "Get-Content -Path C:/TEMP/enable_winrm.txt"
    ]
  }
  provisioner "windows-update" {
    search_criteria = "IsInstalled=0"
    filters = [
      "exclude:$_.Title -like '*Preview*'",
      "exclude:$_.Title -like '*VMware*'",
      "exclude:$_.InstallationBehavior.CanRequestUserInput",
      "exclude:$_.Title -like '*Defender*'",
      "include:$true"
    ]
    update_limit    = 25
    restart_timeout = "120m"
  }
  provisioner "powershell" {
    scripts = [
      "scripts/windows/shutdown.ps1"
    ]
  }
}

source "vsphere-iso" "windows_server_2019_standard_core" {

  // vCenter Server Settings and Credentials
  vcenter_server      = var.default_vsphere_server
  username            = var.env_vsphere_username
  password            = var.env_vsphere_password
  insecure_connection = var.default_insecure_connection

  // vSphere Settings
  cluster    = var.default_vsphere_compute_cluster
  datacenter = var.default_vsphere_datacenter
  datastore  = var.default_vsphere_datastore
  folder     = var.default_vsphere_folder

  // VM Settings
  vm_name       = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${var.vm_guest_os_edition_standard}-${var.vm_guest_os_experience_desktop}"
  CPUs          = var.default_CPUs
  RAM           = var.default_RAM
  firmware      = var.default_firmware
  vm_version    = var.default_vm_version
  guest_os_type = var.vm_guest_os_type
  remove_cdrom  = var.default_remove_cdrom

  network_adapters {
    network      = var.default_vsphere_portgroup_name
    network_card = var.default_network_card
  }
  disk_controller_type = var.default_disk_controller_type
  storage {
    disk_size             = var.default_disk_size
    disk_thin_provisioned = var.default_disk_thin_provisioned
  }

  // Boot & Shutdown Settings
  boot_command     = var.default_boot_command
  boot_order       = var.default_boot_order
  boot_wait        = var.default_boot_wait
  shutdown_timeout = var.default_shutdown_timeout

  // Media Settings
  iso_paths = [var.vm_inst_os_iso_path, var.vm_inst_vmtools_iso_path]
  cd_files = [
    "${path.cwd}/scripts/${var.vm_guest_os_family}/enable_winrm.ps1"
  ]
  cd_content = {
    "autounattend.xml" = templatefile("${abspath(path.root)}/config/windows/autounattend.pkrtpl.hcl", {
      env_communicator_username = var.env_communicator_username
      env_communicator_password = var.env_communicator_password
      vm_inst_os_language       = var.vm_inst_os_language
      vm_inst_os_keyboard       = var.vm_inst_os_keyboard
      vm_inst_os_image          = var.vm_inst_os_image_standard_desktop
      vm_inst_os_kms_key        = var.vm_inst_os_kms_key_standard
      vm_guest_os_language      = var.vm_guest_os_language
      vm_guest_os_keyboard      = var.vm_guest_os_keyboard
      vm_guest_os_timezone      = var.vm_guest_os_timezone
    })

  }

  http_directory = var.vm_inst_http_directory
  http_port_max  = var.vm_inst_http_port_max

  // Communicator Settings
  communicator   = var.default_communicator
  winrm_insecure = var.default_winrm_insecure
  winrm_use_ssl  = var.default_communicator_use_ssl
  winrm_username = var.env_communicator_username
  winrm_password = var.env_communicator_password
  winrm_timeout  = var.default_communicator_timeout


  // Content Library Settings
  content_library_destination {
    name    = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${var.vm_guest_os_edition_standard}-${var.vm_guest_os_experience_desktop}"
    library = var.default_content_library_destination
    destroy = var.default_library_vm_destroy
    ovf     = var.default_ovf
  }
}
# windows_server_2019_standard_core
build {
  sources = ["source.vsphere-iso.windows_server_2019_standard_core"]
  provisioner "powershell" {
    inline = [
      "Get-Content -Path C:/TEMP/enable_winrm.txt"
    ]
  }
  provisioner "windows-update" {
    search_criteria = "IsInstalled=0"
    filters = [
      "exclude:$_.Title -like '*Preview*'",
      "exclude:$_.Title -like '*VMware*'",
      "exclude:$_.InstallationBehavior.CanRequestUserInput",
      "exclude:$_.Title -like '*Defender*'",
      "include:$true"
    ]
    update_limit    = 25
    restart_timeout = "120m"
  }
  provisioner "powershell" {
    scripts = [
      "scripts/windows/shutdown.ps1"
    ]
  }
}

source "vsphere-iso" "windows_server_2022_standard_desktop_experience" {

  // vCenter Server Settings and Credentials
  vcenter_server      = var.default_vsphere_server
  username            = var.env_vsphere_username
  password            = var.env_vsphere_password
  insecure_connection = var.default_insecure_connection

  // vSphere Settings
  cluster    = var.default_vsphere_compute_cluster
  datacenter = var.default_vsphere_datacenter
  datastore  = var.default_vsphere_datastore
  folder     = var.default_vsphere_folder

  // VM Settings
  vm_name       = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${var.vm_guest_os_edition_standard}-${var.vm_guest_os_experience_desktop}"
  CPUs          = var.default_CPUs
  RAM           = var.default_RAM
  firmware      = var.default_firmware
  vm_version    = var.default_vm_version
  guest_os_type = var.vm_guest_os_type
  remove_cdrom  = var.default_remove_cdrom

  network_adapters {
    network      = var.default_vsphere_portgroup_name
    network_card = var.default_network_card
  }
  disk_controller_type = var.default_disk_controller_type
  storage {
    disk_size             = var.default_disk_size
    disk_thin_provisioned = var.default_disk_thin_provisioned
  }

  // Boot & Shutdown Settings
  boot_command     = var.default_boot_command
  boot_order       = var.default_boot_order
  boot_wait        = var.default_boot_wait
  shutdown_timeout = var.default_shutdown_timeout

  // Media Settings
  iso_paths = [var.vm_inst_os_iso_path, var.vm_inst_vmtools_iso_path]
  cd_files = [
    "${path.cwd}/scripts/${var.vm_guest_os_family}/enable_winrm.ps1"
  ]
  cd_content = {
    "autounattend.xml" = templatefile("${abspath(path.root)}/config/windows/autounattend.pkrtpl.hcl", {
      env_communicator_username = var.env_communicator_username
      env_communicator_password = var.env_communicator_password
      vm_inst_os_language       = var.vm_inst_os_language
      vm_inst_os_keyboard       = var.vm_inst_os_keyboard
      vm_inst_os_image          = var.vm_inst_os_image_standard_desktop
      vm_inst_os_kms_key        = var.vm_inst_os_kms_key_standard
      vm_guest_os_language      = var.vm_guest_os_language
      vm_guest_os_keyboard      = var.vm_guest_os_keyboard
      vm_guest_os_timezone      = var.vm_guest_os_timezone
    })

  }

  http_directory = var.vm_inst_http_directory
  http_port_max  = var.vm_inst_http_port_max

  // Communicator Settings
  communicator   = var.default_communicator
  winrm_insecure = var.default_winrm_insecure
  winrm_use_ssl  = var.default_communicator_use_ssl
  winrm_username = var.env_communicator_username
  winrm_password = var.env_communicator_password
  winrm_timeout  = var.default_communicator_timeout


  // Content Library Settings
  content_library_destination {
    name    = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${var.vm_guest_os_edition_standard}-${var.vm_guest_os_experience_desktop}"
    library = var.default_content_library_destination
    destroy = var.default_library_vm_destroy
    ovf     = var.default_ovf
  }
}
# windows_server_2022_standard_desktop_experience
build {
  sources = ["source.vsphere-iso.windows_server_2022_standard_desktop_experience"]
  provisioner "powershell" {
    inline = [
      "Get-Content -Path C:/TEMP/enable_winrm.txt"
    ]
  }
  provisioner "windows-update" {
    search_criteria = "IsInstalled=0"
    filters = [
      "exclude:$_.Title -like '*Preview*'",
      "exclude:$_.Title -like '*VMware*'",
      "exclude:$_.InstallationBehavior.CanRequestUserInput",
      "exclude:$_.Title -like '*Defender*'",
      "include:$true"
    ]
    update_limit    = 25
    restart_timeout = "120m"
  }
  provisioner "powershell" {
    scripts = [
      "scripts/windows/shutdown.ps1"
    ]
  }
}

source "vsphere-iso" "windows_server_2022_standard_core" {

  // vCenter Server Settings and Credentials
  vcenter_server      = var.default_vsphere_server
  username            = var.env_vsphere_username
  password            = var.env_vsphere_password
  insecure_connection = var.default_insecure_connection

  // vSphere Settings
  cluster    = var.default_vsphere_compute_cluster
  datacenter = var.default_vsphere_datacenter
  datastore  = var.default_vsphere_datastore
  folder     = var.default_vsphere_folder

  // VM Settings
  vm_name       = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${var.vm_guest_os_edition_standard}-${var.vm_guest_os_experience_desktop}"
  CPUs          = var.default_CPUs
  RAM           = var.default_RAM
  firmware      = var.default_firmware
  vm_version    = var.default_vm_version
  guest_os_type = var.vm_guest_os_type
  remove_cdrom  = var.default_remove_cdrom

  network_adapters {
    network      = var.default_vsphere_portgroup_name
    network_card = var.default_network_card
  }
  disk_controller_type = var.default_disk_controller_type
  storage {
    disk_size             = var.default_disk_size
    disk_thin_provisioned = var.default_disk_thin_provisioned
  }

  // Boot & Shutdown Settings
  boot_command     = var.default_boot_command
  boot_order       = var.default_boot_order
  boot_wait        = var.default_boot_wait
  shutdown_timeout = var.default_shutdown_timeout

  // Media Settings
  iso_paths = [var.vm_inst_os_iso_path, var.vm_inst_vmtools_iso_path]
  cd_files = [
    "${path.cwd}/scripts/${var.vm_guest_os_family}/enable_winrm.ps1"
  ]
  cd_content = {
    "autounattend.xml" = templatefile("${abspath(path.root)}/config/windows/autounattend.pkrtpl.hcl", {
      env_communicator_username = var.env_communicator_username
      env_communicator_password = var.env_communicator_password
      vm_inst_os_language       = var.vm_inst_os_language
      vm_inst_os_keyboard       = var.vm_inst_os_keyboard
      vm_inst_os_image          = var.vm_inst_os_image_standard_desktop
      vm_inst_os_kms_key        = var.vm_inst_os_kms_key_standard
      vm_guest_os_language      = var.vm_guest_os_language
      vm_guest_os_keyboard      = var.vm_guest_os_keyboard
      vm_guest_os_timezone      = var.vm_guest_os_timezone
    })

  }

  http_directory = var.vm_inst_http_directory
  http_port_max  = var.vm_inst_http_port_max

  // Communicator Settings
  communicator   = var.default_communicator
  winrm_insecure = var.default_winrm_insecure
  winrm_use_ssl  = var.default_communicator_use_ssl
  winrm_username = var.env_communicator_username
  winrm_password = var.env_communicator_password
  winrm_timeout  = var.default_communicator_timeout


  // Content Library Settings
  content_library_destination {
    name    = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${var.vm_guest_os_edition_standard}-${var.vm_guest_os_experience_desktop}"
    library = var.default_content_library_destination
    destroy = var.default_library_vm_destroy
    ovf     = var.default_ovf
  }
}
# windows_server_2022_standard_core
build {
  sources = ["source.vsphere-iso.windows_server_2022_standard_core"]
  provisioner "powershell" {
    inline = [
      "Get-Content -Path C:/TEMP/enable_winrm.txt"
    ]
  }
  provisioner "windows-update" {
    search_criteria = "IsInstalled=0"
    filters = [
      "exclude:$_.Title -like '*Preview*'",
      "exclude:$_.Title -like '*VMware*'",
      "exclude:$_.InstallationBehavior.CanRequestUserInput",
      "exclude:$_.Title -like '*Defender*'",
      "include:$true"
    ]
    update_limit    = 25
    restart_timeout = "120m"
  }
  provisioner "powershell" {
    scripts = [
      "scripts/windows/shutdown.ps1"
    ]
  }
}