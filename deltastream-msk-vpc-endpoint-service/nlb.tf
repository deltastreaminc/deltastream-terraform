# -----------------------------------------------
# NLB to from MSK for vpc private endpoint service
# ------------------------------------------------

resource "aws_lb" "msk-nlb" {

  count = local.create ? 1 : 0

  name               = local.nlb.name

  internal           = true
  load_balancer_type = "network"
  subnets            = data.aws_msk_broker_nodes.msk-broker-nodes[0].node_info_list[*].client_subnet

  tags               = merge(local.tags, {
    Name = local.nlb.name
    LbType = "network"
  })
}
