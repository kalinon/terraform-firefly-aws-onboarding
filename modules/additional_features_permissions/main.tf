data "aws_caller_identity" "current" {}

locals {
  s3_objects = [
    "arn:aws:s3:::*/*tfstate",
    "arn:aws:s3:::elasticbeanstalk*/*",
    "arn:aws:s3:::aws-emr-resources*/*"
  ]
  config_service_objects = ["arn:aws:s3:::*/${data.aws_caller_identity.current.account_id}*ConfigSnapshot*.json.gz"]
  s3_objects_to_allow    = var.use_config_service ?  concat(local.s3_objects, local.config_service_objects) : local.s3_objects
  account_id = data.aws_caller_identity.current.account_id

}


resource "aws_iam_policy" "additional_permissions" {
  name        = "FireflyAdditionalPermissions"
  path        = "/"
  description = "this policy allow grants firefly the permissions for the config service and the event driven features"
  policy      = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      // feature - config service fetching
      {
        "Action" : [
          "config:StartConfigurationRecorder",
          "config:StopConfigurationRecorder",
          "config:PutDeliveryChannel",
          "config:PutConfigurationRecorder",
          "config:DeleteConfigurationRecorder",
          "config:DeleteDeliveryChannel"
        ],
        "Effect" : "Allow",
        "Resource": "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:PassRole"
        ],
        "Resource" : var.config_service_role_arn
        "Condition": {
          "StringEquals": {"iam:PassedToService": "config.amazonaws.com"}
        }
      },
      // specific s3  read permissions
      {
        "Action" : [
          "kms:Decrypt"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:kms:*:${local.account_id}:key/*"
      },
      {
        "Action" : [
          "s3:GetObject"
        ],
        "Effect" : "Deny",
        "NotResource" : local.s3_objects_to_allow
      },
      // feature - bucket notification for event-driven IAC
      {
        "Action" : [
          "s3:PutBucketNotification"
        ],
        "Effect" : "Allow",
        "NotResource" : "arn:aws:s3:::*"
      },
      // feature - event driven inventory
      {
        "Action": [
          "events:*"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:events:*:${local.account_id}:rule/firefly-events-*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "iam:PassRole"
        ],
        "Resource": var.invoke_firefly_event_bus_arn,
        "Condition": {
          "StringEquals": {"iam:PassedToService": "events.amazonaws.com"}
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "firefly_additional_permissions" {
  depends_on = [aws_iam_policy.additional_permissions]
  policy_arn = aws_iam_policy.additional_permissions.arn
  role       = var.firefly_role_name
}