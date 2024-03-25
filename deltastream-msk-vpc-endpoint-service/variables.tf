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
  default = "dp-aldf0-stage-xbg2-0"
}

variable "enable_sasl_scram_ports" {
  type = bool
  description = "Expose SASL/SCRAM ports for the MSK cluster."
  default = false
}

variable "enable_sasl_iam_ports" {
  type = bool
  description = "Expose IAM ports for the MSK cluster."
  default = true
}

variable "tags" {
  type = map(string)
  description = "Tags to apply to the resources."
  default = {
    "Name" = "msk-vpc-endpoint-service"
  }
}

variable "resource_prefix" {
  type = string
  description = "Prefix to apply to the resources."
  default = "ds-"
}
