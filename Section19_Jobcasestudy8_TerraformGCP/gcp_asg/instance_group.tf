resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10                         # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}

resource "google_compute_instance_group_manager" "appserver" {
  name = "appservers"

  base_instance_name = "app"
  instance_template  = "${google_compute_instance_template.default.self_link}"
  update_strategy    = "NONE"
  zone               = "${var.region}-a"

  //target_pools = ["${google_compute_target_pool.appserver.self_link}"]
 //target_size  = 2

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = "${google_compute_health_check.autohealing.self_link}"
    initial_delay_sec = 300
  }
}

resource "google_compute_autoscaler" "foobar" {
  name   = "scaler"
  zone   = "${var.region}-a"
  target = "${google_compute_instance_group_manager.appserver.self_link}"

  autoscaling_policy = {
    max_replicas    = 5
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}
