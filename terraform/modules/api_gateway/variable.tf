variable "api_name" {
  type        = string
  description = "The name of the REST API Gateway"
  default     = "myRest-api"
}

variable "lambda_function_invoke_arn" {
  type        = string
  description = "Invoke ARN of the Lambda function to integrate with API Gateway"
}

variable "lambda_function_name" {
  type        = string
  description = "name of the Lambda function to integrate with API Gateway"
}

variable "cors_allowed_origins" {
  type        = list(string)
  description = "List of allowed origins for CORS"
  default     = ["*"]
}

variable "cors_allowed_methods" {
  type        = list(string)
  description = "Allowed HTTP methods for CORS"
  default     = ["GET", "POST", "OPTIONS"]
}

variable "cors_allowed_headers" {
  type        = list(string)
  description = "Allowed headers for CORS"
  default     = ["Content-Type", "X-Amz-Date", "Authorization", "X-Api-Key", "X-Amz-Security-Token"]
}
