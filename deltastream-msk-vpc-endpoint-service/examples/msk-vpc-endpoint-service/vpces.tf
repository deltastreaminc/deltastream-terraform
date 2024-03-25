# -----------------------------------------------
#  create vpc private endpoint service
# ------------------------------------------------

module msk-vpces {

  source = "../../"

  name_prefix = local.name_prefix
  msk_cluster_name = local.msk_cluster_name
  enable_sasl_scram_ports = local.enable_sasl_scram_ports
  enable_sasl_iam_ports = local.enable_sasl_iam_ports

  additional_tags = local.additional_tags
}
