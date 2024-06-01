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

resource "aws_sqs_queue" "deadletter_queue" {
  count = var.has_deadletter_queue ? 1 : 0
  name  = "${local.queue_name}-deadletter-queue"
}

resource "aws_sqs_queue_redrive_allow_policy" "queue_redrive_allow_policy" {
  count     = var.has_deadletter_queue ? 1 : 0
  queue_url = aws_sqs_queue.deadletter_queue.url
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.queue.arn]
  })
}

resource "aws_sqs_queue_redrive_policy" "name" {
  count     = var.has_deadletter_queue ? 1 : 0
  queue_url = aws_sqs_queue.queue.url
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter_queue.arn
    maxReceiveCount     = 3
  })
}
