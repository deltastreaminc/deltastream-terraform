# -----------------------------------------------
# Data Resources for vpc private endpoint service
# ------------------------------------------------

data "aws_msk_cluster" "msk-cluster" {

  count = local.create ? 1 : 0

  cluster_name = var.msk_cluster_name
}

data "aws_msk_broker_nodes" "msk-broker-nodes" {

  count = local.create ? 1 : 0

  cluster_arn = data.aws_msk_cluster.msk-cluster[0].arn
}

data "aws_subnet" "msk-aws-subnet" {

  count = local.create ? length(data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list) : 0

  id    = data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list[count.index].client_subnet
}

data "aws_network_interface" "msk-network-interface" {

  count = local.create ? length(data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list) : 0

  id    = data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list[count.index].attached_eni_id
}
