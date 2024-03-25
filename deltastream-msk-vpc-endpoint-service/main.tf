data "aws_msk_cluster" "msk_cluster" {
  cluster_name = var.msk_cluster_name
}

data "aws_msk_broker_nodes" "msk_broker_nodes" {
  cluster_arn = data.aws_msk_cluster.msk_cluster.arn
}

data "aws_subnet" "msk_aws_subnet" {
  count = length(data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list)
  id    = data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list[count.index].client_subnet
}

data "aws_network_interface" "msk_network_interface" {
  count = length(data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list)
  id    = data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list[count.index].attached_eni_id
}

resource "aws_lb" "msk_nlb" {
  name               = "${var.resource_prefix}nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list[*].client_subnet
  tags               = var.tags
}

locals {
  sasl_iam_host_port_map = var.enable_sasl_iam_ports ? { for k in split(",", data.aws_msk_cluster.msk_cluster.bootstrap_brokers_sasl_iam) : split(":", k)[0] => tonumber(split(":", k)[1]) } : {}
}

resource "aws_lb_target_group" "msk_sasl_iam_target_group" {
  count       = length(data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list) * (var.enable_sasl_iam_ports ? 1 : 0)
  name        = "${var.resource_prefix}iam-tg-${count.index}"
  port        = local.sasl_iam_host_port_map[tolist(data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list[count.index].endpoints)[0]]
  protocol    = "TCP"
  vpc_id      = data.aws_network_interface.msk_network_interface[count.index].vpc_id
  target_type = "ip"
  tags        = var.tags
}

resource "aws_lb_target_group_attachment" "msk_sasl_iam_target_group_target" {
  count            = length(data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list) * (var.enable_sasl_iam_ports ? 1 : 0)
  target_group_arn = aws_lb_target_group.msk_sasl_iam_target_group[count.index].arn
  target_id        = data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list[count.index].client_vpc_ip_address # ENI IP, target type = IP
}

resource "aws_lb_listener" "msk_iam_listener" {
  count              = length(data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list) * (var.enable_sasl_iam_ports ? 1 : 0)
  load_balancer_arn  = aws_lb.msk_nlb.arn
  port               = 9001 + count.index
  protocol           = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.msk_sasl_iam_target_group[count.index].arn
  }
  tags               = var.tags
}

locals {
  sasl_scram_host_port_map = var.enable_sasl_scram_ports ? { for k in split(",", data.aws_msk_cluster.msk_cluster.bootstrap_brokers_sasl_scram) : split(":", k)[0] => tonumber(split(":", k)[1]) } : {}
}

resource "aws_lb_target_group" "msk_sasl_scram_target_group" {
  count       = length(data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list) * (var.enable_sasl_scram_ports ? 1 : 0)
  name        = "${var.resource_prefix}sasl-tg-${count.index}"
  port        = local.sasl_scram_host_port_map[tolist(data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list[count.index].endpoints)[0]]
  protocol    = "TCP"
  vpc_id      = data.aws_network_interface.msk_network_interface[count.index].vpc_id
  target_type = "ip"
  tags        = var.tags
}

resource "aws_lb_target_group_attachment" "msk_sasl_scram_target_group_target" {
  count            = length(data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list) * (var.enable_sasl_scram_ports ? 1 : 0)
  target_group_arn = aws_lb_target_group.msk_sasl_scram_target_group[count.index].arn
  target_id        = data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list[count.index].client_vpc_ip_address # ENI IP, target type = IP
}

resource "aws_lb_listener" "msk_scram_listener" {
  count              = length(data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list) * (var.enable_sasl_scram_ports ? 1 : 0)
  load_balancer_arn  = aws_lb.msk_nlb.arn
  port               = 9101 + count.index
  protocol           = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.msk_sasl_scram_target_group[count.index].arn
  }
  tags               = var.tags
}

resource "aws_vpc_endpoint_service" "msk_aws_vpc_endpoint_service" {
  acceptance_required        = true
  network_load_balancer_arns = [aws_lb.msk_nlb.arn]
  tags                       = var.tags
}

locals {
  sasl_iam_table = var.enable_sasl_iam_ports ? [
      for idx, b in data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list : {
        "MSK host": tolist(b.endpoints)[0],
        "MSK port": local.sasl_iam_host_port_map[tolist(b.endpoints)[0]],
        "Private link port": 9001 + idx,
        "Availability zone ID": data.aws_subnet.msk_aws_subnet[idx].availability_zone_id
      }
    ] : []
  sasl_scram_table = var.enable_sasl_scram_ports ? [
      for idx, b in data.aws_msk_broker_nodes.msk_broker_nodes.node_info_list : {
        "MSK host": tolist(b.endpoints)[0],
        "MSK port": local.sasl_scram_host_port_map[tolist(b.endpoints)[0]], 
        "Private link port": 9101 + idx,
        "Availability zone ID": data.aws_subnet.msk_aws_subnet[idx].availability_zone_id
      }
    ] : []
}
