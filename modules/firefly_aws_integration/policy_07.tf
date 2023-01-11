resource "aws_iam_policy" "firefly_readonly_policy_part7" {
  name        = "FireflyReadonlyPolicy_part7"
  path        = "/"
  description = "Read only permission for the cloud configuration Part7"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "transcribe:Describe*",
          "transcribe:List*",
          "transfer:Describe*",
          "transfer:List*",
          "translate:Describe*",
          "translate:List*",
          "voiceid:Describe*",
          "voiceid:List*",
          "waf-regional:GetByteMatchSet",
          "waf-regional:GetGeoMatchSet",
          "waf-regional:GetIPSet",
          "waf-regional:GetLoggingConfiguration",
          "waf-regional:GetRateBasedRule",
          "waf-regional:GetRegexMatchSet",
          "waf-regional:GetRegexPatternSet",
          "waf-regional:GetRule",
          "waf-regional:GetRuleGroup",
          "waf-regional:GetSizeConstraintSet",
          "waf-regional:GetSqlInjectionMatchSet",
          "waf-regional:GetWebACL",
          "waf-regional:GetWebACLForResource",
          "waf-regional:GetXssMatchSet",
          "waf-regional:List*",
          "waf:GetByteMatchSet",
          "waf:GetGeoMatchSet",
          "waf:GetIPSet",
          "waf:GetLoggingConfiguration",
          "waf:GetRateBasedRule",
          "waf:GetRegexMatchSet",
          "waf:GetRegexPatternSet",
          "waf:GetRule",
          "waf:GetRuleGroup",
          "waf:GetSizeConstraintSet",
          "waf:GetSqlInjectionMatchSet",
          "waf:GetWebACL",
          "waf:GetXssMatchSet",
          "waf:List*",
          "wafv2:Describe*",
          "wafv2:GetIPSet",
          "wafv2:GetLoggingConfiguration",
          "wafv2:GetRegexPatternSet",
          "wafv2:GetRuleGroup",
          "wafv2:GetWebACL",
          "wafv2:GetWebACLForResource",
          "wafv2:List*",
          "wisdom:List*",
          "worklink:DescribeA*",
          "worklink:List*",
          "workmail:Describe*",
          "workmail:List*",
          "xray:GetEncryptionConfig",
          "xray:GetGroup",
          "xray:GetSamplingRules",
          "xray:List*",
          "cloudwatch:ListMetricStreams",
          "cloudwatch:ListDashboards"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}