# create CREATORDER lambda function
resource "aws_lambda_function" "CreateOrder_lambda" {
  function_name = var.CreateOder_lambda_name
  role = var.CreatOrder_lambda_role_arn
  runtime = "python3.12"
  handler = "Lambda_CreateOrder.lambda_handler"
  filename = "./lambda/lambda_function_CreatOrder.zip"
  source_code_hash = filebase64sha256("./lambda/lambda_function_CreatOrder.zip")

  environment {
    variables = var.ev_CreateOrder_lambda
  }

}


# create processing lambda function
resource "aws_lambda_function" "processing_lambda" {
  function_name = var.processing_lambda_name
  role = var.processing_lambda_role_arn
  runtime = "python3.12"
  handler = "working_procesor.lambda_handler"
  filename = "./lambda/lambda_function_processing.zip"
  source_code_hash = filebase64sha256("./lambda/lambda_function_processing.zip")

  environment {
    variables = var.ev_processing_lambda
  }
  
}