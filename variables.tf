variable "access_ip" {
  description = "IP Address to be white-listed"
}

variable "ssh_pubkey_path" {
  description = "SSH Public Key path"
  default     = "~/.ssh/id_rsa.pub"
}

variable "instance_type" {
  default = "t2.2xlarge"
}

variable "instance_rootfs_size" {
  default = "80"
}
