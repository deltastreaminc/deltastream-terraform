variable "deltastream_account_id" {
  type = string
  description = "the AWS account_id provided by DeltaStream."

  validation {
    condition     = length(var.deltastream_account_id) >= 1 && var.deltastream_account_id != ""
    error_message = "Set account_id to a valid aws account_id provided by DeltaStream."
  }
}

variable "deltastream_organization_id" {
  type = string
  description = "The Organization ID within the DeltaStream cloud."
}

variable "msk_region" {
  type = string
  description = "The AWS region hosting MSK"

  validation {
    condition     = length(var.msk_region) >= 1 && var.msk_region != ""
    error_message = "Set region to a valid aws region."
  }
}

variable "msk_cluster_name" {
  type = string
  description = <<EOF
  The name of the MSK Cluster.
  
  E.g. For an ARN arn:aws:kafka:us-west-2:123456789012:cluster/my-msk-123/ffab6be5-b41a-cc33-8e23-90098cbbde86-10,
  the cluster name is my-msk-123.
EOF

  validation {
    condition     = length(var.msk_cluster_name) >= 1 && var.msk_cluster_name != ""
    error_message = "Set msk_cluster_name to a valid MSK name."
  }
}

variable "msk_cluster_id" {
  type = string
  description = <<EOF
  The unique identifier found as a suffix within MSK Cluster ARN.
  
  E.g. For an ARN arn:aws:kafka:us-west-2:123456789012:cluster/my-msk-123/ffab6be5-b41a-cc33-8e23-90098cbbde86-10,
  the cluster id is ffab6be5-b41a-cc33-8e23-90098cbbde86-10.
EOF

  validation {
    condition     = length(var.msk_cluster_id) >= 1 && var.msk_cluster_id != ""
    error_message = "Set msk_cluster_id to a valid MSK ID."
  }
}

variable "read_topic_prefix" {
  type = string
  description = "The topic prefix allowed for read operations. Leave empty to allow all topics."
}

variable "write_topic_prefix" {
  type = string
  description = "The topic prefix allowed for write and alter operations. Leave empty to allow all topics."
}

variable "create_topic_prefix" {
  type = string
  description = "The topic prefix allowed for topic creation operations. Leave empty to allow all topics."
}

variable "delete_topic_prefix" {
  type = string
  description = "The topic prefix allowed for topic deletion operations. Leave empty to allow all topics."
}
