

resource "aws_sqs_queue" "my_queue" {
  name                      = var.queue_name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  delay_seconds              = var.delay_seconds
  message_retention_seconds  = var.message_retention_seconds
  fifo_queue                 = var.fifo_queue
  policy = var.sqs_policy

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}

resource "aws_lambda_event_source_mapping" "sqs_trigger_for_processing_lambda" {
  event_source_arn  = aws_sqs_queue.my_queue.arn
  function_name     = var.processing_lambda_arn
  batch_size        = 5
  enabled           = true
}