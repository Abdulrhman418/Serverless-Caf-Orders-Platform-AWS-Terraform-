output "api_id" {
  description = "The ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.myrest_api.id
}

output "api_invoke_url" {
  description = "Invoke URL for the deployed API Gateway stage"
  value       = "${aws_api_gateway_rest_api.myrest_api.execution_arn}/${aws_api_gateway_stage.rest_api_stage.stage_name}"
}

output "api_deployment_id" {
  description = "The deployment ID of the API Gateway"
  value       = aws_api_gateway_deployment.rest_api_deployment.id
}

output "api_stage_name" {
  description = "The stage name of the deployed API Gateway"
  value       = aws_api_gateway_stage.rest_api_stage.stage_name
}
