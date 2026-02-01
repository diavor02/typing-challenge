resource "cloudflare_load_balancer_monitor" "http" {
  account_id = var.cloudflare_account_id
  type       = "http"
  description = "Main HTTP health check"

  method  = "GET"
  path    = "/health"
  interval = 60
  port    = 80
  timeout = 5
  retries = 2

  expected_codes = "200"

  header = {
    header = "X-Health-Check"
    values = [ var.x-health-check-value ]
  }
}

resource "cloudflare_load_balancer_pool" "app_pool" {
  account_id = var.cloudflare_account_id
  name       = "app-pool"
  enabled    = true
  monitor    = cloudflare_load_balancer_monitor.http.id

  origins = [{
    name    = "vm-1"
    address = google_compute_address.vm_static_ip["vm1"].address
    enabled = true
  },
  {
    name    = "vm-2"
    address = google_compute_address.vm_static_ip["vm2"].address
    enabled = true
  }
  ]

  depends_on = [
    cloudflare_load_balancer_monitor.http
  ]
}


resource "cloudflare_load_balancer" "app_lb" {
  zone_id = var.zone_id

  default_pools = [cloudflare_load_balancer_pool.app_pool.id]
  fallback_pool = cloudflare_load_balancer_pool.app_pool.id

  name = "www.typing-game.xyz"
  
  proxied = true
}
