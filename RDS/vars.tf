variable "provider_region" {
  type = string
}
variable "db-engine" {
  type = string
}
variable "db-engine_version" {
  type = string
}
variable "db-instance_class" {
  type = string
}
variable "db-allocated_storage" {
  type = number
}
variable "db-name" {
  type = string
}
variable "db-username" {
  type = string
}
variable "db-password" {
  type = string
}
variable "skip_final_snapshot" {
  type = bool
}
variable "deletion_protection" {
  type = bool
}
variable "publicly_accessible" {
  type = bool
}
variable "identifier-name" {
  type = string
}