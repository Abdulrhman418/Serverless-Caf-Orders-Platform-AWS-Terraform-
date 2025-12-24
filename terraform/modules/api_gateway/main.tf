resource "aws_api_gateway_rest_api" "myrest_api" {
  name = var.api_name

  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = var.api_name
      version = "1.0"
    }
    paths = {
      "/orders": {
        get = {
          "x-amazon-apigateway-integration" = {
            type                 = "aws_proxy"
            httpMethod           = "POST"
            uri                  = var.lambda_function_invoke_arn
            passthroughBehavior  = "when_no_match"
            payloadFormatVersion = "2.0"
          }
          responses = {}
        }
        post = {
          "x-amazon-apigateway-integration" = {
            type                 = "aws_proxy"
            httpMethod           = "POST"
            uri                  = var.lambda_function_invoke_arn
            passthroughBehavior  = "when_no_match"
            payloadFormatVersion = "2.0"
          }
          responses = {}
        }
        options = {
          summary = "CORS support"
          responses = {
            "200" = {
              description = "Default response for CORS method"
              headers = {
                "Access-Control-Allow-Origin"  = { schema = { type = "string" } }
                "Access-Control-Allow-Methods" = { schema = { type = "string" } }
                "Access-Control-Allow-Headers" = { schema = { type = "string" } }
              }
            }
          }
          "x-amazon-apigateway-integration" = {
            type             = "mock"
            requestTemplates = { "application/json" = "{\"statusCode\": 200}" }
            responses = {
              "default" = {
                statusCode = "200"
                responseParameters = {
                  "method.response.header.Access-Control-Allow-Origin"  = join(",", var.cors_allowed_origins) == "*" ? "'*'" : "'${join(", ", var.cors_allowed_origins)}'"
                  "method.response.header.Access-Control-Allow-Methods" = "'${join(",", var.cors_allowed_methods)}'"
                  "method.response.header.Access-Control-Allow-Headers" = "'${join(",", var.cors_allowed_headers)}'"
                }
              }
            }
          }
        }
      }
    }
  })
}

resource "aws_api_gateway_deployment" "rest_api_deployment" {
  depends_on = [aws_api_gateway_rest_api.myrest_api]
  rest_api_id = aws_api_gateway_rest_api.myrest_api.id
}

resource "aws_api_gateway_stage" "rest_api_stage" {
  stage_name    = "dev"
  rest_api_id   = aws_api_gateway_rest_api.myrest_api.id
  deployment_id = aws_api_gateway_deployment.rest_api_deployment.id

  variables = {
    lambda_function_invoke_arn = var.lambda_function_invoke_arn
  }

  description = "dev stage for the API Gateway"
}

resource "aws_lambda_permission" "lambda_permission" {
  depends_on    = [aws_api_gateway_stage.rest_api_stage]
  statement_id  = "AllowAPIInvokeLmbda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.myrest_api.execution_arn}/${aws_api_gateway_stage.rest_api_stage.stage_name}/*"
}
