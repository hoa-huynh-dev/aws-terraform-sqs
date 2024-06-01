variable "queue_name" {
  type = string
}

variable "queue_prefix" {
  type = string
}
variable "queue_tags" {
  type    = map(string)
  default = {}
}

variable "visibility_timeout_seconds" {
  type    = number
  default = 30
}

variable "message_retention_seconds" {
  type    = number
  default = 345600 # 4 days
}

variable "max_message_size" {
  type    = number
  default = 262144 # 256KB
}

variable "delay_seconds" {
  type    = number
  default = 0
}

variable "receive_wait_time_seconds" {
  type    = number
  default = 0
}

variable "sqs_managed_sse_enabled" {
  type    = bool
  default = true
}

variable "fifo_queue" {
  type    = bool
  default = false
}

variable "has_deadletter_queue" {
  type    = bool
  default = false
}
