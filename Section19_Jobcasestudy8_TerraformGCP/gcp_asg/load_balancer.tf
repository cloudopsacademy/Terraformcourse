resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name       = "${var.pname}-global-forwarding-rule"
  //project    = "${var.pname}"
  target     = "${google_compute_target_http_proxy.target_http_proxy.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "target_http_proxy" {
  name        = "${var.pname}-proxy"
  //project     = "${var.pname}"
  url_map     = "${google_compute_url_map.url_map.self_link}"
}

resource "google_compute_url_map" "url_map" {
  name            = "${var.pname}-url-map"
  //project         = "${var.pname}"
  default_service = "${google_compute_backend_service.backend_service.self_link}"
}

resource "google_compute_backend_service" "backend_service" {
  name                  = "${var.pname}-backend-service"
  //project               = "${var.pname}"
  port_name             = "http"
  protocol              = "HTTP"
  backend {
    group                 = "${element(google_compute_instance_group_manager.appserver.*.instance_group, 0)}"
    balancing_mode        = "RATE"
    max_rate_per_instance = 100
  }

  backend {
    group                 = "${element(google_compute_instance_group_manager.appserver.*.instance_group, 1)}"
    balancing_mode        = "RATE"
    max_rate_per_instance = 100
  }

  health_checks = ["${google_compute_http_health_check.healthcheck.self_link}"]
}

resource "google_compute_http_health_check" "healthcheck" {
  name         = "${var.pname}-healthcheck"
  //project      = "${var.pname}"
  port         = 80
  request_path = "/"
}
