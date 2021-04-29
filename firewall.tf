resource "google_compute_firewall" "this" {
  name    = "${var.name}-allow-healthcheck"
  network = data.google_compute_network.network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  
  priority = 1000
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags = var.tags
}
