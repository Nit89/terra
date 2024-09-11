# outputs.tf
output "vm_instance_name" {
  value = google_compute_instance.vm_instance.name
}

output "vm_instance_external_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "firewall_rule_name" {
  value = google_compute_firewall.allow_http.name
}


# Apply the Changes: To create the VM instance and configure the firewall, run:
# terraform apply -var="project_id=<your-gcp-project-id>"
