resource "yandex_lb_network_load_balancer" "app_balancer" {
  name = "app-load-balancer"

  listener {
    name        = "reddit-listener"
    port        = 8080
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit.id
    healthcheck {
      name = "app-healthcheck"
      http_options {
        port = "9292"
      }
    }
  }
}

resource "yandex_lb_target_group" "reddit" {
  name      = "reddit"
  region_id = var.lb_region
  folder_id = var.folder_id

  dynamic "target" {
    for_each = yandex_compute_instance.app.*.network_interface.0.ip_address
    content {
      address   = target.value
      subnet_id = var.subnet_id
    }
  }

}

output "external_ip_address_balancer" {
  value = yandex_lb_network_load_balancer.app_balancer.listener.*.external_address_spec[0].*.address
}
