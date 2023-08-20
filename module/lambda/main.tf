#lambdaにアタッチするロール(ロールは必須)
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

#関数ファイルのzip化
data "archive_file" "function_file" {
  type = "zip"
  source_file = "module/lambda/src/hello.py"
  output_path = "module/lambda/src/hello.zip"
}
#Layerファイルのzip化
data "archive_file" "layer_file" {
  type = "zip"
  source_file = "module/lambda/requirements.txt"
  output_path = "module/lambda/requirements.zip"
}

#Layer
resource "aws_lambda_layer_version" "function_layer" {
  layer_name = "lambda_function_layer"
  filename = "module/lambda/requirements.zip"
}

#Lambda関数
resource "aws_lambda_function" "test_function" {
  filename = "module/lambda/src/hello.zip"
  function_name = "hello"
  role = aws_iam_role.iam_for_lambda.arn
  handler = "hello.lambda_handler"
  runtime = "python3.10"
layers = ["${aws_lambda_layer_version.function_layer.arn}"]

  environment {
    variables = {
        DUMMY_URL = var.dummy_url
    }
  }
}