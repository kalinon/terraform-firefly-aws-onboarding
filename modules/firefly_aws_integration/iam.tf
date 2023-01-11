resource "aws_iam_role" "firefly_cross_account_access_role" {
  name               = var.role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "AWS" : "arn:aws:iam::${local.organizationID}:root"
        },
        "Effect" : "Allow",
        "Condition" : {
          "StringEquals" : {
            "sts:ExternalId" : var.role_external_id
          }
        }
      }
    ]
  })
  managed_policy_arns = [
    aws_iam_policy.firefly_readonly_policy_part1.arn,
    aws_iam_policy.firefly_readonly_policy_part2.arn,
    aws_iam_policy.firefly_readonly_policy_part3.arn,
    aws_iam_policy.firefly_readonly_policy_part4.arn,
    aws_iam_policy.firefly_readonly_policy_part5.arn,
    aws_iam_policy.firefly_readonly_policy_part6.arn,
    aws_iam_policy.firefly_readonly_policy_part7.arn,
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "arn:aws:iam::aws:policy/SecurityAudit",
  ]
}