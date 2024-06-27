resource "google_compute_global_address" "default" {
  name    = "global-ip"
  project = var.project_id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "http-proxy"
  url_map = google_compute_url_map.default.id
  project = var.project_id
}

resource "google_compute_url_map" "default" {
  name            = "url-map"
  default_service = google_compute_backend_service.default.id
  project         = var.project_id
}

resource "google_compute_backend_service" "default" {
  name                  = "backend-service"
  port_name             = "http"
  protocol              = "HTTP"
  health_checks         = [google_compute_http_health_check.default.id]
  backend {
    group = var.instance_group_self_link
  }
  project = var.project_id
}

variable "instance_group_self_link" {
  description = "Self link of the instance group"
  type        = string
}
resource "google_compute_http_health_check" "default" {
  name                = "http-health-check"
  request_path        = "/"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  project = var.project_id
}

resource "google_compute_forwarding_rule" "default" {
  name                  = "forwarding-rule"
  target                = google_compute_target_http_proxy.default.id
  port_range            = "80"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  project               = var.project_id
}
