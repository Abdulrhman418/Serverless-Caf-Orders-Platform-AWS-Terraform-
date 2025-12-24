# ARN of dynamo table
variable "table_arn" {
  description = "ARN of the DynamoDB table"
  type        = string
}

# name of sns topic
variable "sns_topic_arn" {
  description = "ARN of the sns topic"
  type    = string
}

# arn of sqs queuq 
variable "queue_arn" {
  description = "arn of the SQS queue"
  type        = string
}



# trust policy
variable "lambda_assume_role_policy" {
  description = "Assume role policy for Lambda function"
  type        = string
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

