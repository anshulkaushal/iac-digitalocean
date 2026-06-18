resource "digitalocean_droplet" "ubuntu" {
  name     = var.droplet_name
  region   = var.region
  size     = var.size
  image    = var.image
  ssh_keys = var.ssh_key_ids

  monitoring = var.monitoring
  ipv6       = var.ipv6
  tags       = var.tags
}
