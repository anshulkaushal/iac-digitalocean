output "droplet_id" {
  description = "ID of the created droplet."
  value       = digitalocean_droplet.ubuntu.id
}

output "droplet_name" {
  description = "Name of the created droplet."
  value       = digitalocean_droplet.ubuntu.name
}

output "droplet_ipv4_address" {
  description = "Public IPv4 address of the droplet."
  value       = digitalocean_droplet.ubuntu.ipv4_address
}

output "droplet_ipv6_address" {
  description = "Public IPv6 address of the droplet (if enabled)."
  value       = digitalocean_droplet.ubuntu.ipv6_address
}

output "droplet_urn" {
  description = "Uniform resource name of the droplet."
  value       = digitalocean_droplet.ubuntu.urn
}

output "ssh_command" {
  description = "Example SSH command to connect as root."
  value       = "ssh root@${digitalocean_droplet.ubuntu.ipv4_address}"
}
