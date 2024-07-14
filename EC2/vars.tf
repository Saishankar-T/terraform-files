variable "provider_region" {
  type = string
}
variable "instance_ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "instance_key_name" {
  type = string
}
variable "instance_name" {
  type = string
}
variable "root_volume_size" {
  type = number
}
variable "ebs_volume_az" {
  type = string
}
variable "ebs_volume_size" {
  type = number
}
