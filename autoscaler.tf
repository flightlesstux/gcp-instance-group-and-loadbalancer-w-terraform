resource "google_compute_autoscaler" "this" {
  name   = "${var.name}-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.this.id

  autoscaling_policy {
    max_replicas    = 8
    min_replicas    = var.minimum_vm_size
    cooldown_period = 30

    cpu_utilization {
      target = 0.72
    }
  }

  depends_on = [ google_compute_instance_group_manager.this ]
}
