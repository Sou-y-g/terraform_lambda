module "lambda" {
  source = "./module/lambda"

  dummy_url = var.dummy_url
}