output "queue_name" {
  value = aws_sqs_queue.queue.name
}

output "queue_id" {
  value = aws_sqs_queue.queue.id
}

output "queue_arn" {
  value = aws_sqs_queue.queue.arn
}
