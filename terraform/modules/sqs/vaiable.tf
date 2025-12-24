variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "test"
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout for SQS messages in seconds"
  type        = number
  default     = 30
}

variable "delay_seconds" {
  description = "Delay seconds for SQS queue"
  type        = number
  default     = 0
}

variable "message_retention_seconds" {
  description = "Message retention period in seconds"
  type        = number
  default     = 345600
}

variable "fifo_queue" {
  description = "Whether the queue is FIFO"
  type        = bool
  default     = false
}

variable "processing_lambda_arn" {
    description = "ARN of the Lambda function that processes messages from the SQS queue"
    type        = string
}

variable "sqs_policy" {
  description = "SQS queue policy JSON"
  type        = string
  default = <<EOF
{
  "Version": "2012-10-17",
  "Id": "QueuePolicyForTwoLambdas",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::881490118287:role/CreatOrder_lambda_sqs_dynamo_role"
      },
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:us-east-1:881490118287:test"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::881490118287:role/processing_lambda_sqs_dynamo_sns_role"
      },
      "Action": [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ],
      "Resource": "arn:aws:sqs:us-east-1:881490118287:test"
    }
  ]
}
EOF
}
