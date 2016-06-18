variable "buckets" {}
variable "iam_user_group_name" {
  default = "s3_users"
}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

module "s3_bucket_users" {
  source = "../s3_bucket_users"
  buckets = "${var.buckets}"
  iam_user_group_name = "${var.iam_user_group_name}"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"
}

resource "aws_s3_bucket" "b" {
  count = "${length(split(",", var.buckets))}"
  bucket = "${element(split(",", var.buckets), count.index)}"
}

output "users" {
  value = "${join(" ", module.s3_bucket_users.users)}"
}

output "keys" {
  value = "${join(" ", module.s3_bucket_users.keys)}"
}

output "secrets" {
  value = "${join(" ", module.s3_bucket_users.secrets)}"
}
