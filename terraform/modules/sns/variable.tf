variable "sns_topic_name" {
  type    = string
  default = "test"
}
variable "subscription_email" {
  type    = string
  default = "abdulrhamanmokhtar399@gmail.com"
}

variable "sns_topic_policy" {
  type = string
  default = <<EOF
{
  "Version": "2012-10-17",
  "Id": "SNSPolicyForLambdaPublish",
  "Statement": [
    {
      "Sid": "AllowLambdaPublishOnly",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::881490118287:role/processing_lambda_sqs_dynamo_sns_role"
      },
      "Action": "SNS:Publish",
      "Resource": "arn:aws:sns:us-east-1:123456789012:test",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws:lambda:us-east-1:123456789012:function:processing_lambda"
        }
      }
    }
  ]
}
EOF
}
