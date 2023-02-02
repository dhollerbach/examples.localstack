module "lambda_python_example" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "python-example"
  description   = "My awesome lambda function"
  handler       = "main.lambda_handler"
  runtime       = "python3.8"

  source_path = "../src/python-example"
}

module "lambda_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "lambda-image"
  description   = "My awesome lambda function"

  create_package = false

  image_uri    = "public.ecr.aws/poc-hello-world/hello-service:latest"
  package_type = "Image"
}
