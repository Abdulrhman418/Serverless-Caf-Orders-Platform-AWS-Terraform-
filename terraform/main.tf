

module "s3_cloudfront" {
  source = "./modules/s3_cloudfront"
}
module "cognito" {
  source = "./modules/cognito"
  cloudfront_domain = module.s3_cloudfront.cloudfront_distribution_domain_name
}

module "role" {
  source = "./modules/role"
  table_arn = module.dynamoDB.dynamodb_table_arn
  queue_arn = module.sqs.sqs_queue_arn
  sns_topic_arn = module.sns.sns_topic_arn
}

module "dynamoDB" {
  source = "./modules/dynamodb"
}
module "sqs" {
  source = "./modules/sqs"
  processing_lambda_arn = module.lambda_function.processing_lambda_arn


}
module "sns" {
  source = "./modules/sns"
}

module "lambda_function" {
  source = "./modules/lambda_function"
  CreatOrder_lambda_role_arn = module.role.CreateOrder_lambda_role_arn
  processing_lambda_role_arn = module.role.Working_lambda_role_arn
  ev_CreateOrder_lambda = {
    ORDERS_TABLE = module.dynamoDB.dynamodb_table_name,
    ORDERS_QUEUE_URL = module.sqs.sqs_queue_url
  }
  ev_processing_lambda = {
    ORDERS_TABLE = module.dynamoDB.dynamodb_table_name,
    REPORTS_TOPIC_ARN = module.sns.sns_topic_arn
  }
}
  
module "api_gateway" {
  source = "./modules/api_gateway"
  lambda_function_invoke_arn = module.lambda_function.CreateOrder_lambda_invoke_arn
  lambda_function_name = module.lambda_function.CreateOrder_lambda_name
}

