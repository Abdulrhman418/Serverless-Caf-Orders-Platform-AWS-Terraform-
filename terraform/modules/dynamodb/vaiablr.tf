variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "ORDERS_TABLE"
}

variable "billing_mode" {
  description = "Billing mode for DynamoDB table"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Partition key for the DynamoDB table"
  type        = string
  default     = "orderId"
}