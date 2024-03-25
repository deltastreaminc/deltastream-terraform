# deltastream-msk-vpc-endpoint-service

[add descrition]


## Requisites
* Install terraform >= 0.15

## Setup: AWS Cli

```
export AWS_ACCESS_KEY_ID=<your access key>
export AWS_SECRET_ACCESS_KEY=<your secret key>
  - optionally, set export AWS_PROFILE=<profile-name>
    - if you are using use AWS Profile from aws credentials file.
```


## Configure AWS Credentials
* Set up AWS Config and Credentials
```
cat ~/.aws/config
[default]
region = us-west-2

[prod]
region = us-west-2
```

```
cat ~/.aws/credentials
[default]
aws_access_key_id = <your non-prod access key>
aws_secret_access_key = <your non-prod secret key>

[dev]
aws_access_key_id = <your prod access key>
aws_secret_access_key = <your prod secret key>
```

* Switch between account credentials
1. To switch to dev environment
```
export AWS_PROFILE=dev
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.25.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.25.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.msk-nlb](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/resources/lb) | resource |
| [aws_lb_listener.msk-iam-listener](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener.msk-scram-listener](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.msk-sasl-iam-target-group](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.msk-sasl-scram-target-group](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.msk-sasl-iam-target-group-target](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.msk-sasl-scram-target-group-target](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_vpc_endpoint_service.msk-aws-vpc-endpoint-service](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/resources/vpc_endpoint_service) | resource |
| [random_string.resource-id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_msk_broker_nodes.msk-broker-nodes](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/data-sources/msk_broker_nodes) | data source |
| [aws_msk_cluster.msk-cluster](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/data-sources/msk_cluster) | data source |
| [aws_network_interface.msk-network-interface](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/data-sources/network_interface) | data source |
| [aws_subnet.msk-aws-subnet](https://registry.terraform.io/providers/hashicorp/aws/5.25.0/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional Tags to apply to the resources. | `map(string)` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Controls if VPC Endpoint Service related resources should be created (affects nearly all resources) | `bool` | `true` | no |
| <a name="input_enable_sasl_iam_ports"></a> [enable\_sasl\_iam\_ports](#input\_enable\_sasl\_iam\_ports) | Expose IAM ports for the MSK cluster. | `bool` | `true` | no |
| <a name="input_enable_sasl_scram_ports"></a> [enable\_sasl\_scram\_ports](#input\_enable\_sasl\_scram\_ports) | Expose SASL/SCRAM ports for the MSK cluster. | `bool` | `false` | no |
| <a name="input_msk_cluster_name"></a> [msk\_cluster\_name](#input\_msk\_cluster\_name) | The name of the MSK Cluster.<br><br>  E.g. For an ARN arn:aws:kafka:us-west-2:123456789012:cluster/my-msk-123/ffab6be5-b41a-cc33-8e23-90098cbbde86-10,<br>  the cluster name is my-msk-123. | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix to apply to the resources. | `string` | `"ds-"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_msk_endpoint_service_id"></a> [msk\_endpoint\_service\_id](#output\_msk\_endpoint\_service\_id) | Return the aws\_vpc\_endpoint\_service: service id for the MSK endpoint service |
| <a name="output_msk_endpoint_service_name"></a> [msk\_endpoint\_service\_name](#output\_msk\_endpoint\_service\_name) | Return the aws\_vpc\_endpoint\_service: service\_name for the MSK endpoint service |
| <a name="output_table"></a> [table](#output\_table) | n/a |
<!-- END_TF_DOCS -->
