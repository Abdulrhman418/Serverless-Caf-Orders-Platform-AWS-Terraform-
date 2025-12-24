

# create role for Create Order lambda function 
resource "aws_iam_role" "CreateOrder_lambda_role" {
  name               = "CreatOrder_lambda_sqs_dynamo_role"
  assume_role_policy = var.lambda_assume_role_policy

}

resource "aws_iam_role_policy" "CreateOrder_lambda_policy" {
  name   = "CreateOrder_lambda_sqs_dynamo_policy"
  role   = aws_iam_role.CreateOrder_lambda_role.id
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:GetItem"
      ],
      "Resource": "${var.table_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": "${var.queue_arn}"
    }
  ]
})

}


# create role for Working lambda function 
resource "aws_iam_role" "Working_lambda_role" {
  name               = "processing_lambda_sqs_dynamo_sns_role"
  assume_role_policy = var.lambda_assume_role_policy
  
}

resource "aws_iam_role_policy" "Working_lambda_policy" {
  name   = "processing_lambda_sqs_dynamo_sns_policy"
  role   = aws_iam_role.Working_lambda_role.id
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ],
      "Resource": "${var.queue_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:GetItem"
      ],
      "Resource": "${var.table_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "sns:Publish"
      ],
      "Resource": "${var.sns_topic_arn}"
    }
  ]
})

}
