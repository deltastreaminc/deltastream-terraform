output "deltastream_msk_role_id" {
  value = aws_iam_role.deltastream-msk-role.id
  description = "ID of the DeltaStreamMSKRole"
}

output "deltastream_msk_iam_role_policy_id" {
  value = aws_iam_role_policy.deltastream-msk-iam-role-policy.id
  description = "ID of the policy attached to DeltaStreamMSKRole"
}
