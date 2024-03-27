# --------------------------------------------------------------
# NLB Target Groups to from MSK for vpc private endpoint service
# ---------------------------------------------------------------

resource "aws_lb_target_group" "msk-sasl-iam-target-group" {
  count       = local.nlb-listener.enable_sasl_iam_ports ? length(data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list) : 0

  name        = format("%s-%s", local.nlb-tg.iam-name, count.index)
  port        = local.sasl_iam_host_port_map[tolist(data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list[count.index].endpoints)[0]]
  protocol    = "TCP"
  target_type = "ip"

  vpc_id      = data.aws_network_interface.msk-network-interface[count.index].vpc_id

  tags               = merge(local.tags, {
    Name = format("%s-%s", local.nlb-tg.iam-name, count.index)
    Description = format("%s %s-%s %s", "IAM port NLB Target Group for NLB", local.nlb.name, count.index, local.msk.cluster_name)
  })
}

resource "aws_lb_target_group_attachment" "msk-sasl-iam-target-group-target" {

  count            = local.nlb-listener.enable_sasl_iam_ports ? length(data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list) : 0

  target_group_arn = aws_lb_target_group.msk-sasl-iam-target-group[count.index].arn

  # ENI IP, target type = IP
  target_id        = data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list[count.index].client_vpc_ip_address
}

resource "aws_lb_target_group" "msk-sasl-scram-target-group" {

  count       = local.nlb-listener.enable_sasl_scram_ports ? length(data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list) : 0

  name        = format("%s-%s", local.nlb-tg.scram-name, count.index)

  port        = local.sasl_scram_host_port_map[tolist(data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list[count.index].endpoints)[0]]
  protocol    = "TCP"
  target_type = "ip"

  vpc_id      = data.aws_network_interface.msk-network-interface[count.index].vpc_id

  tags               = merge(local.tags, {
    Name = format("%s-%s", local.nlb-tg.scram-name, count.index)
    Description = format("%s %s-%s %s", "Scram port NLB Target Group for NLB", local.nlb.name, count.index, local.msk.cluster_name)
  })
}

resource "aws_lb_target_group_attachment" "msk-sasl-scram-target-group-target" {

  count            = local.nlb-listener.enable_sasl_scram_ports ? length(data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list) : 0

  target_group_arn = aws_lb_target_group.msk-sasl-scram-target-group[count.index].arn
  target_id        = data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list[count.index].client_vpc_ip_address # ENI IP, target type = IP
}
