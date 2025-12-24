# role arn for Create Order lambda function
output "CreateOrder_lambda_role_arn" {
  description = "ARN of the CreateOrder Lambda IAM Role"
  value       = aws_iam_role.CreateOrder_lambda_role.arn
}

# role arn for procissing Order lambda function
output "Working_lambda_role_arn" {
  description = "ARN of the Working Lambda IAM Role"
  value       = aws_iam_role.Working_lambda_role.arn
}
