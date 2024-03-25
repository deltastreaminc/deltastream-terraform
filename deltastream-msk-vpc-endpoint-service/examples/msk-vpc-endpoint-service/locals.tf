# -----------------------------------------------
# Locals for vpc private endpoint service
# ------------------------------------------------
locals {

  name_prefix      = var.name_prefix
  msk_cluster_name = var.msk_cluster_name
  enable_sasl_scram_ports = var.enable_sasl_scram_ports
  enable_sasl_iam_ports = var.enable_sasl_iam_ports
  additional_tags = merge(var.additional_tags, {
    TestcaseName = "example/msk-vpc-endpoint-service"
  })

}
