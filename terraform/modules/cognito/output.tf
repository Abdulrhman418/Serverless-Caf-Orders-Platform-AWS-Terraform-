# output for cognito user pool id
output "cognito_user_pool_id" {
  description = "The ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.user_pool.id
}

# output for cognito_user_pool_client_id
output "cognito_user_pool_client_id" {
  description = "The ID of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.client_app.id
}

# output for cognito_user_pool_client_callback_urls
output "cognito_user_pool_client_callback_urls" {
  description = "Callback URLs for the User Pool Client"
  value       = aws_cognito_user_pool_client.client_app.callback_urls
}

# output for cognito domain
output "cognito_domain" {
  description = "cognito domain for user pool client"
  value       = aws_cognito_user_pool_domain.user_pool_domian.domain
}