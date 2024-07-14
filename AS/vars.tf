variable "provider_region" {
  type = string
}
variable "template_image_id" {
  type = string
}
variable "template_instance_type" {
  type = string
}
variable "template_key_name" {
  type = string
}
variable "template_name" {
  type = string
}
variable "template_resource_type" {
  type = string
}
variable "template_instances_name" {
  type = string
}
variable "asg_name" {
  type = string
}
variable "asg_min_size" {
  type = number
}
variable "asg_max_size" {
  type = number
}
variable "asg_desired_capacity" {
  type = number
}
variable "asg_az" {
  type = set(string)
}