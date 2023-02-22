variable "region" {
  description = "aws region"
  type        = string
}

variable "account_id" {
  type    = string
}

variable "identifiers" {
  type = list(string)
  default = []
}

variable "tags" {
  type = map(string)
  default = {}
}
