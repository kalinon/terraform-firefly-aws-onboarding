output "firefly_integration_role_name" {
  value = aws_iam_role.firefly_cross_account_access_role.name
}

output "firefly_integration_role_arn" {
  value = aws_iam_role.firefly_cross_account_access_role.arn
}

output "template_vesion" {
  value = local.version
}

output "firefly_allow_list__policy_arn_part_1" {
  value = aws_iam_policy.firefly_readonly_policy_part1.arn
}

output "firefly_allow_list__policy_arn_part_2" {
  value = aws_iam_policy.firefly_readonly_policy_part2.arn
}

output "firefly_allow_list__policy_arn_part_3" {
  value = aws_iam_policy.firefly_readonly_policy_part3.arn
}

output "firefly_allow_list__policy_arn_part_4" {
  value = aws_iam_policy.firefly_readonly_policy_part4.arn
}

output "firefly_allow_list__policy_arn_part_5" {
  value = aws_iam_policy.firefly_readonly_policy_part5.arn
}

output "firefly_allow_list__policy_arn_part_6" {
  value = aws_iam_policy.firefly_readonly_policy_part6.arn
}

output "firefly_allow_list__policy_arn_part_7" {
  value = aws_iam_policy.firefly_readonly_policy_part7.arn
}


