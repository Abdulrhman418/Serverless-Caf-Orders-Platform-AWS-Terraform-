# name of CreateOder lambda
variable "CreateOder_lambda_name" {
  description = "name of createOrder lambda"
  type        = string
  default     = "CreateOder_lambda"
}

# name of processing lambda
variable "processing_lambda_name" {
  description = "name of processing lambda"
  type        = string
  default     = "processing_lambda"
}


# role for creat order lambda function role arn
variable "CreatOrder_lambda_role_arn" {
  description = "ARN of the Create order lambda function role"
  type        = string
}

# role for processing lambda function role arn
variable "processing_lambda_role_arn" {
  description = "ARN of the processing lambda function role"
  type        = string
}

# environment variable for CreateOrder lambda function
variable "ev_CreateOrder_lambda" {
  description = "environment variable for CreateOrder lambda function"
  type        = object({
    ORDERS_TABLE = string
    ORDERS_QUEUE_URL = string
  })
}

# environment variable for processing lambda function
variable "ev_processing_lambda" {
  description = "environment variable for processing lambda function"
  type        = object({
    ORDERS_TABLE = string
    REPORTS_TOPIC_ARN = string
  })
}

