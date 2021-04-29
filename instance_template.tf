resource "google_compute_instance_template" "this" {
  name        = "${var.name}-${var.deploy_version}"
  description = var.instance_template_description
  
  tags = var.tags

  labels = {
    service = var.name
    version = var.deploy_version
  }

  metadata = {
    version = var.deploy_version
    block-project-ssh-keys = true
  }

  instance_description    = var.instance_description
  machine_type            = var.machine_type
  can_ip_forward          = false
  metadata_startup_script = "${file("./startup/script.sh")}"

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = var.image
    boot         = true
    disk_type    = "pd-balanced"
  }

  network_interface {
    network    = data.google_compute_network.network.name
    subnetwork = data.google_compute_subnetwork.subnet.name
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.this.email
    scopes = ["cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
