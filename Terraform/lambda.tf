# Image Gen Lambda Function
resource "aws_lambda_function" "spooky_days_image_lambda_function" {
  function_name = local.image_lambda_function_name
  role          = aws_iam_role.image_lambda_execution_role.arn
  handler       = "image_gen.handler"
  s3_bucket     = aws_s3_bucket.spooky_days_lambda_bucket.bucket
  s3_key        = data.aws_s3_object.spooky_days_object.key

  runtime = "python3.10"

  timeout = 120

  layers = [
    data.aws_lambda_layer_version.spooky_days_lambda_layer.arn,
    data.aws_lambda_layer_version.boto3_lambda_layer.arn
  ]

  environment {
    variables = {
      OPENAI_API_KEY  = var.OPENAI_API_KEY
      JPG_BUCKET_NAME = var.JPG_BUCKET_NAME
    }
  }
}

# Twitter Post Lambda Function
resource "aws_lambda_function" "spooky_days_twitter_lambda_function" {
  function_name = local.twitter_lambda_function_name
  role          = aws_iam_role.twitter_lambda_execution_role.arn
  handler       = "twitter_post.handler"
  s3_bucket     = aws_s3_bucket.spooky_days_lambda_bucket.bucket
  s3_key        = data.aws_s3_object.spooky_days_object_twitter.key

  runtime = "python3.10"

  timeout = 120

  layers = [
    data.aws_lambda_layer_version.tweepy_lambda_layer.arn,
    data.aws_lambda_layer_version.boto3_lambda_layer.arn
  ]

  environment {
    variables = {
      bearer_token        = var.twitter_bearer_token
      api_key             = var.twitter_api_key
      api_secret          = var.twitter_api_secret
      access_token        = var.twitter_access_token
      access_token_secret = var.twitter_access_token_secret
      JPG_BUCKET_NAME     = var.JPG_BUCKET_NAME
    }
  }
}
