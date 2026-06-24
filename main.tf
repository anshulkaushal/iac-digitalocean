resource "digitalocean_droplet" "ubuntu" {
  name     = var.droplet_name
  region   = var.region
  size     = var.size
  image    = var.image
  ssh_keys = var.ssh_key_ids

  monitoring = var.monitoring
  ipv6       = var.ipv6
  tags       = var.tags

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(pathexpand(var.ssh_private_key_path))
      host        = self.ipv4_address
    }

    source      = "${path.module}/scripts/provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(pathexpand(var.ssh_private_key_path))
      host        = self.ipv4_address
    }

    inline = [
      "sed -i 's/\\r$//' /tmp/provision.sh",
      "chmod +x /tmp/provision.sh",
      "bash /tmp/provision.sh",
    ]
  }
}
