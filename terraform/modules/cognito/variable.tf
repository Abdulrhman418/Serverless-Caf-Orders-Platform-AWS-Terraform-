# name of user pool
variable "user_pool_name" {
  description = "name of user pool"
  type = string
  default = "my_user_pool454"
}

# name of client app
variable "client_app_name" {
  description = "name of user pool"
  type = string
  default = "my_client_app5454"
}

# name of cognito doman
variable "cognito_domain" {
  description = "name of cognito domani "
  type = string
  default = "myapp-auth-domain-8354354683"
}

# name of cloudfront doman
variable "cloudfront_domain" {
  description = "name of cloudfront domani "
  type = string
}
