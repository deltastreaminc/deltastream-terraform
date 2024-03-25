# -----------------------------------------------
# NLB to from MSK for vpc private endpoint service
# ------------------------------------------------

resource "aws_lb_listener" "msk-iam-listener" {

  count              = local.nlb-listener.enable_sasl_iam_ports ? length(data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list) : 0

  load_balancer_arn  = aws_lb.msk-nlb[0].arn
  port               = 9001 + count.index
  protocol           = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.msk-sasl-iam-target-group[count.index].arn
  }

  tags               = merge(local.tags, {
    Name = format("%s-%s", local.nlb-listener.iam-name, count.index)
    Description = format("%s %s-%s %s", "IAM port NLB Listener for NLB", local.nlb.name, count.index, local.msk.cluster_name)
  })
}


resource "aws_lb_listener" "msk-scram-listener" {

  count              = local.nlb-listener.enable_sasl_scram_ports ? length(data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list) : 0

  load_balancer_arn  = aws_lb.msk-nlb[0].arn
  port               = 9101 + count.index
  protocol           = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.msk-sasl-scram-target-group[count.index].arn
  }

  tags               = merge(local.tags, {
    Name = format("%s-%s", local.nlb-listener.scram-name, count.index)
    Description = format("%s %s-%s %s", "Scram port NLB Listener for NLB", local.nlb.name, local.msk.cluster_name)
  })
}
