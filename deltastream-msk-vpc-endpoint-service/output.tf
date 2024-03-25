
# Return the aws_vpc_endpoint_service resource for the MSK endpoint service including the service name and ID
output "msk_endpoint_service" {
    value = aws_vpc_endpoint_service.msk_aws_vpc_endpoint_service
}

output "table" {
    value = concat(local.sasl_iam_table, local.sasl_scram_table)
}
