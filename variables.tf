variable "do_token" {
  description = "DigitalOcean API token. Prefer DO_TOKEN env var or terraform.tfvars (not committed)."
  type        = string
  sensitive   = true
}

variable "droplet_name" {
  description = "Name tag for the droplet."
  type        = string
  default     = "ubuntu-basic"
}

variable "region" {
  description = "DigitalOcean region slug (e.g. nyc1, sfo3, lon1)."
  type        = string
  default     = "nyc1"
}

variable "size" {
  description = "Droplet size slug (e.g. s-1vcpu-1gb)."
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "image" {
  description = "OS image slug."
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "ssh_key_ids" {
  description = "List of SSH key IDs or fingerprints to install on the droplet."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to the droplet."
  type        = list(string)
  default     = ["iac", "terraform"]
}

variable "monitoring" {
  description = "Enable DigitalOcean monitoring agent."
  type        = bool
  default     = true
}

variable "ipv6" {
  description = "Enable IPv6 on the droplet."
  type        = bool
  default     = true
}
