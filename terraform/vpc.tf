resource "google_compute_network" "vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false   # Custom mode
  routing_mode            = "REGIONAL"
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "subnetwork1"
  ip_cidr_range = "10.1.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc.id

  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "EXTERNAL"
}

# Allow ssh from gcp infrastructure
resource "google_compute_firewall" "ingress-firewall-ssh-gcp" {
  name    = "ingress-firewall-ssh-gcp"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = [ "35.235.240.0/20" ]
}

# Allow Ansible to access the vms. In a production environment I would use a bastion vm.
resource "google_compute_firewall" "ingress-firewall-ssh-vpn" {
  name    = "ingress-firewall-ssh-vpn"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = [ "0.0.0.0/0" ]
}

# Allow ingress from Cloudflare edge network
resource "google_compute_firewall" "ingress-firewall-ip-v4" {
  name    = "ingress-firewall-ip-v4"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = local.ip_v4_list
}

resource "google_compute_firewall" "ingress-firewall-ip-v6" {
  name    = "ingress-firewall-ip-v6"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = local.ip_v6_list
}

# Allow egress to the internet
resource "google_compute_firewall" "egress-firewall" {
  name    = "egress-firewall"
  network = google_compute_network.vpc.name

  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports = [ "80", "443" ]
  }

  destination_ranges = ["0.0.0.0/0"]
}

# All internet traffic goes to the internet gateway
resource "google_compute_route" "router" {
  name        = "network-route"
  dest_range  = "0.0.0.0/0"
  network     = google_compute_network.vpc.name
  next_hop_gateway = "default-internet-gateway"
}
