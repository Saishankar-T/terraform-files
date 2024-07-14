variable "provider_region" {
  type = string
}
variable "que_name" {
  type = string
}
variable "que_type" {
  type = bool
}
variable "visibility_timeout_seconds" {
  type = number
}
variable "message_retention_seconds" {
  type = number
}
variable "delay_seconds" {
  type = number
}
variable "max_message_size" {
  type = number
}
variable "receive_wait_time_seconds" {
  type = number
}