variable "region" {
  description = "The AWS region we want this bucket to live in."
  default     = "eu-west-1"
}

variable "profile" {
  description = "the aws profile to use"
  default = "prod"
}

variable "env" {
  description = "current environment"
  default = "test"
}

variable "app_name" {
  description = "The AWS region we want this bucket to live in."
  default     = "event-streaming"
}

variable "account_id" {
  default = "your_account_id"
  description = "aws account id"
}
