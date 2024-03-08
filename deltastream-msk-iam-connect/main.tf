data "aws_caller_identity" "current_account" {}

resource "aws_iam_role" "deltastream-msk-role" {
  name = "DeltaStreamMSKRole"
  path = "/"
  assume_role_policy = jsonencode( {
      "Statement": [
      {
        "Effect": "Allow",
        "Principal": { "AWS": "arn:aws:iam::${var.deltastream_account_id}:role/DeltaStreamCrossAccountRole" },
        "Action": [ "sts:AssumeRole" ],
        "Condition":  {
          "StringEquals": {
              "sts:ExternalId": "${md5(var.deltastream_organization_id)}"
          }
        }
      }]
  })
}

data "template_file" "deltastream-msk-iam-role-policy-file" {
  template = "${file("policy.json.tpl")}"

  vars = {
    aws_account_id = data.aws_caller_identity.current_account.account_id
    region = var.msk_region
    msk_cluster_name = var.msk_cluster_name
    msk_cluster_id = var.msk_cluster_id
    read_topic_prefix = var.read_topic_prefix
    write_topic_prefix = var.write_topic_prefix
    create_topic_prefix = var.create_topic_prefix
    delete_topic_prefix = var.delete_topic_prefix
  }
}

resource "aws_iam_role_policy" "deltastream-msk-iam-role-policy" {
  name = "DeltaStreamMskIamRolePolicy"
  role = aws_iam_role.deltastream-msk-role.id

  policy = "${data.template_file.deltastream-msk-iam-role-policy-file.rendered}"
}
