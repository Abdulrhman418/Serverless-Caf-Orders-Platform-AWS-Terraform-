output "sqs_queue_url" {
  description = "URL of the created SQS queue"
  value       = aws_sqs_queue.my_queue.id
}

output "sqs_queue_arn" {
  description = "ARN of the created SQS queue"
  value       = aws_sqs_queue.my_queue.arn
}

output "sqs_queue_name" {
  description = "name of the created sqs queue"
  value = aws_sqs_queue.my_queue.name
}
