variable "buckets" {}
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

resource "aws_iam_user" "s3_users" {
  count = "${length(split(",", var.buckets))}"
  name = "${element(split(",", var.buckets), count.index)}"
}

resource "aws_iam_access_key" "s3_users" {
  count = "${length(split(",", var.buckets))}"
  user = "${element(split(",", var.buckets), count.index)}"
  depends_on = ["aws_iam_user.s3_users"]
}

resource "aws_iam_group_membership" "s3_users" {
  name = "tf-s3-group-membership"
  users = ["${aws_iam_user.s3_users.*.name}"]
  group = "${aws_iam_group.s3_users.name}"
}

resource "aws_iam_group_policy" "s3_users" {
  name = "s3_users_policy"
  group = "${aws_iam_group.s3_users.name}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::$${aws:username}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::$${aws:username}/*"
        }
    ]
}
EOF
}

resource "aws_iam_group" "s3_users" {
  name = "s3_users"
}

resource "aws_s3_bucket" "b" {
  count = "${length(split(",", var.buckets))}"
  bucket = "${element(split(",", var.buckets), count.index)}"
}
