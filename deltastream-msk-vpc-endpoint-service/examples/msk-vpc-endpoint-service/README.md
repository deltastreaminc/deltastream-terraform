# examples/msk-vpc-endpoint-service
[add description]

# Usage: how to run
- update vpces.tfvars

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.25.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_msk-vpces"></a> [msk-vpces](#module\_msk-vpces) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional Tags to apply to the resources. | `map(string)` | n/a | yes |
| <a name="input_enable_sasl_iam_ports"></a> [enable\_sasl\_iam\_ports](#input\_enable\_sasl\_iam\_ports) | Expose IAM ports for the MSK cluster. | `bool` | `true` | no |
| <a name="input_enable_sasl_scram_ports"></a> [enable\_sasl\_scram\_ports](#input\_enable\_sasl\_scram\_ports) | Expose SASL/SCRAM ports for the MSK cluster. | `bool` | `false` | no |
| <a name="input_msk_cluster_name"></a> [msk\_cluster\_name](#input\_msk\_cluster\_name) | The name of the MSK Cluster.<br><br>  E.g. For an ARN arn:aws:kafka:us-west-2:123456789012:cluster/my-msk-123/ffab6be5-b41a-cc33-8e23-90098cbbde86-10,<br>  the cluster name is my-msk-123. | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix to apply to the resources. | `string` | `"ds-"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
