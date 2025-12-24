resource "aws_sns_topic" "my_topic" {
  name = var.sns_topic_name
  policy = var.sns_topic_policy
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.my_topic.arn
  protocol  = "email"
  endpoint  = var.subscription_email
}
