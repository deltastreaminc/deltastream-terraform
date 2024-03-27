# -----------------------------------------------
# Local Resources for vpc private endpoint service
# ------------------------------------------------

locals {

  create = var.create
  name_prefix = format("%s-%s", var.name_prefix, lower(random_string.resource-id[0].result))

  msk = {
    cluster_name = var.msk_cluster_name
  }

  nlb = {
    name = format("%s-%s", local.name_prefix, "nlb")
  }

  nlb-listener = {
    iam-name = format("%s-%s", local.name_prefix, "nlb-iam")
    scram-name = format("%s-%s", local.name_prefix, "nlb-scram")

    enable_sasl_iam_ports   = local.create && var.enable_sasl_iam_ports
    enable_sasl_scram_ports = local.create && var.enable_sasl_scram_ports
  }

  nlb-tg = {
    iam-name = format("%s-%s", local.name_prefix, "iam-tg")
    scram-name = format("%s-%s", local.name_prefix, "scram-tg")
  }

  vpc-endpoint-service = {
    name = format("%s-%s", local.name_prefix, "vpces")
  }

  sasl_iam_host_port_map = var.enable_sasl_iam_ports ? { for k in split(",", data.aws_msk_cluster.msk-cluster[0].bootstrap_brokers_sasl_iam) : split(":", k)[0] => tonumber(split(":", k)[1]) } : {}
  sasl_scram_host_port_map = var.enable_sasl_scram_ports ? { for k in split(",", data.aws_msk_cluster.msk-cluster[0].bootstrap_brokers_sasl_scram) : split(":", k)[0] => tonumber(split(":", k)[1]) } : {}

  sasl_iam_table = var.enable_sasl_iam_ports ? [
    for idx, b in data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list : {
      "MSK host": tolist(b.endpoints)[0],
      "MSK port": local.sasl_iam_host_port_map[tolist(b.endpoints)[0]],
      "Private link port": 9001 + idx,
      "Availability zone ID": data.aws_subnet.msk-aws-subnet[idx].availability_zone_id
    }
  ] : []

  sasl_scram_table = var.enable_sasl_scram_ports ? [
    for idx, b in data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list : {
      "MSK host": tolist(b.endpoints)[0],
      "MSK port": local.sasl_scram_host_port_map[tolist(b.endpoints)[0]],
      "Private link port": 9101 + idx,
      "Availability zone ID": data.aws_subnet.msk-aws-subnet[idx].availability_zone_id
    }
  ] : []

  tags = merge({
    MskClusterName = var.msk_cluster_name
  }, var.additional_tags)

}
