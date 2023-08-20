variable "region" {
  description = "The region where to deploy the infrastructure"
  type        = string
  default     = "ap-northeast-1"
}

variable "tag" {
  description = "Prefix for the tags"
  default     = "slack_billing"
}

variable "dummy_url" {
  description = "dummy_url"
  type = string
  default = "http://example.com"
}