resource "google_compute_ssl_certificate" "this" {
  name_prefix = "${var.name}-ssl-"
  private_key = file("./certs/private.key")
  certificate = file("./certs/certificate.crt")

  lifecycle {
    create_before_destroy = true
  }
}
