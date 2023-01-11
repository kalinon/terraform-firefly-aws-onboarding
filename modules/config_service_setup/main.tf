data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "config_service_management_policy" {
  name        = "ConfigServiceManagementPolicy"
  path        = "/"
  description = "this policy allows the config service to use it's s3 bucket to store the service's data"
  policy      = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:*"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "${aws_s3_bucket.config_bucket.arn}",
          "${aws_s3_bucket.config_bucket.arn}/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:CreateLogGroup"
        ],
        "Resource" : "arn:aws:logs:*:*:log-group:/aws/config/*"
      },
      {
        "Effect" : "Allow",
        "Action" : "logs:PutLogEvents",
        "Resource" : "arn:aws:logs:*:*:log-group:/aws/config/*:log-stream:config-rule-evaluation/*"
      }
    ]
  })
}

resource "aws_iam_role" "aws_config_role" {
  depends_on = [aws_iam_policy.config_service_management_policy]
  name                = "aws-config-role-firefly"
  description         = "this role allows the config service a read only permissions to the cloud configuration, and permissions to it's s3 bucket"
  assume_role_policy  = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
  managed_policy_arns = [
    var.firefly_allow_list_policy_arn_part_1,
    var.firefly_allow_list_policy_arn_part_2,
    var.firefly_allow_list_policy_arn_part_3,
    var.firefly_allow_list_policy_arn_part_4,
    var.firefly_allow_list_policy_arn_part_5,
    var.firefly_allow_list_policy_arn_part_6,
    var.firefly_allow_list_policy_arn_part_7,
    aws_iam_policy.config_service_management_policy.arn,
    "arn:aws:iam::aws:policy/SecurityAudit",
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
  ]
}

resource "aws_s3_bucket" "config_bucket" {
  bucket        = "aws-config-service-bucket-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}
