# -----------------------------------------------
# Output Resources for vpc private endpoint service
# ------------------------------------------------

# Return the aws_vpc_endpoint_service: service_name for the MSK endpoint service
output "msk_endpoint_service_name" {
    value = try(aws_vpc_endpoint_service.msk-aws-vpc-endpoint-service[0].service_name, "")
}

# Return the aws_vpc_endpoint_service: service id for the MSK endpoint service
output "msk_endpoint_service_id" {
    value = try(aws_vpc_endpoint_service.msk-aws-vpc-endpoint-service[0].id, "")
}

output "table" {
    value = concat(local.sasl_iam_table, local.sasl_scram_table)
}
