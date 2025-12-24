# invoked ARN for the create order lambda function
output "CreateOrder_lambda_invoke_arn" {
  value = aws_lambda_function.CreateOrder_lambda.invoke_arn
}

# invoked ARN for the processing lambda function
output "processing_lambda_invoke_arn" {
  value = aws_lambda_function.processing_lambda.invoke_arn
}

# ARN for the processing lambda function
output "processing_lambda_arn" {
  value = aws_lambda_function.processing_lambda.arn
}

# name of the create order lambda function
output "CreateOrder_lambda_name" {
  value = aws_lambda_function.CreateOrder_lambda.function_name
}

# name of the processing lambda function
output "processing_lambda_name" {
  value = aws_lambda_function.processing_lambda.function_name
}


