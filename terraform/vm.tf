resource "google_compute_address" "vm_static_ip" {
  for_each = {
    vm1 = "vm1-static-ip"
    vm2 = "vm2-static-ip"
  }

  name   = each.value
  region = "us-central1"
}

resource "google_compute_instance" "vm_instance" {
  for_each = {
    vm1 = "vm1"
    vm2 = "vm2"
  }

  name         = each.value
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet1.id

    access_config {
      nat_ip = google_compute_address.vm_static_ip[each.key].address
    }
  }
}
