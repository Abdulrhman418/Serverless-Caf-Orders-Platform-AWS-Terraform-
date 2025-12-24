
# create a cognito user pool 
resource "aws_cognito_user_pool" "user_pool" {
  name = "my-user-pool"

  schema {

    name                     = "email"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = true
    developer_only_attribute = false
    string_attribute_constraints {
      min_length = 5
      max_length = 50
    }

  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_uppercase                = true
    require_numbers                  = true
    require_symbols                  = false
    temporary_password_validity_days = 30
  }

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]


  username_configuration {
    case_sensitive = true

  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

}


# create a congito user pool client
resource "aws_cognito_user_pool_client" "client_app" {
  name                            = var.client_app_name
  user_pool_id                    = aws_cognito_user_pool.user_pool.id
  generate_secret                 = false

  supported_identity_providers    = ["COGNITO"]
  allowed_oauth_flows             = ["implicit"]
  allowed_oauth_scopes            = ["email", "openid", "profile"]
  allowed_oauth_flows_user_pool_client = true
  prevent_user_existence_errors = "ENABLED"

  callback_urls                  = ["https://${var.cloudfront_domain}/callback.html"]
  logout_urls                    = ["https://${var.cloudfront_domain}/index.html"]

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]

  refresh_token_validity = 1
  access_token_validity = 1
  id_token_validity = 1
  token_validity_units {
    access_token = "hours"
    id_token = "hours"
    refresh_token = "days"
  }

}




# create a cognito user pool domain
resource "aws_cognito_user_pool_domain" "user_pool_domian" {
  domain       = var.cognito_domain
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

