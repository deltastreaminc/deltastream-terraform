# -----------------------------------------------
#  vpc private endpoint service
# ------------------------------------------------

resource "aws_vpc_endpoint_service" "msk-aws-vpc-endpoint-service" {

  count = local.create ? 1 : 0

  acceptance_required        = true
  network_load_balancer_arns = [
    aws_lb.msk-nlb[0].arn
  ]

  tags                       = merge(local.tags, {
    Name = local.vpc-endpoint-service.name
  })
}
