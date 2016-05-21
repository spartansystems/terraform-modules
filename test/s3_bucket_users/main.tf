module "s3_bucket_users" {
  source = "../../s3_bucket_users"
  buckets = "first_test_user,second_test_user"
  iam_user_group_name = "s3_bucket_users_group"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"
}
