locals {
  queue_name = "${var.queue_prefix}-${var.queue_name}"
}

resource "aws_sqs_queue" "queue" {
  name                       = local.queue_name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  sqs_managed_sse_enabled    = var.sqs_managed_sse_enabled
  fifo_queue                 = var.fifo_queue
  tags                       = var.queue_tags
}
