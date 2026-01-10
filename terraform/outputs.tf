# Outputing the ip addresses as the hosts accessible from ansible

output "vm1_ip" {
  value = google_compute_instance.vm_instance["vm1"].network_interface[0].access_config[0].nat_ip
  sensitive = false
}

output "vm2_ip" {
  value = google_compute_instance.vm_instance["vm2"].network_interface[0].access_config[0].nat_ip
  sensitive = false
}
