resource "google_compute_instance_template" "default" {
  name         = "nginx-template"
  machine_type = "e2-medium"

  disk {
    source_image = "debian-cloud/debian-10"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = var.private_subnet
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
EOF
}

resource "google_compute_instance_group_manager" "default" {
  name               = "nginx-instance-group"
  base_instance_name = "nginx-instance"
  target_size        = 3
  zone               = "${var.region}-a"

  version {
    instance_template = google_compute_instance_template.default.id
  }

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check = google_compute_health_check.default.id
    initial_delay_sec = 300
  }
}

resource "google_compute_health_check" "default" {
  name = "nginx-health-check"
  tcp_health_check {
    port = 80
  }
}

resource "google_compute_autoscaler" "default" {
  name               = "nginx-autoscaler"
  target             = google_compute_instance_group_manager.default.id
  zone               = "${var.region}-a"
  autoscaling_policy {
    max_replicas    = 10
    min_replicas    = 3
    cpu_utilization {
      target = 0.6
    }
  }
}
