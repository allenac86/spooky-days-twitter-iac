data "aws_s3_object" "spooky_days_object" {
  bucket = aws_s3_bucket.spooky_days_lambda_bucket.bucket
  key    = var.image_lambda_zip_filename
}

data "aws_s3_object" "spooky_days_object_twitter" {
  bucket = aws_s3_bucket.spooky_days_lambda_bucket.bucket
  key    = var.twitter_lambda_zip_filename
}

data "aws_lambda_layer_version" "spooky_days_lambda_layer" {
  layer_name = var.layer_name
}

data "aws_lambda_layer_version" "boto3_lambda_layer" {
  layer_name = var.boto3_layer_name
}

data "aws_lambda_layer_version" "tweepy_lambda_layer" {
  layer_name = var.tweepy_layer_name
}

data "aws_ami" "amazon_linux_2023_ami" {
  owners = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "image-id"
    values = ["ami-0bb84b8ffd87024d8"]
  }
}
