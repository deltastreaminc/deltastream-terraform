# IAM Role Policies for MSK connectivity with DeltaStream platform

This module sets up an IAM role and policies that establish a trust relationship that allows you to connect to your cluster from the DeltaStream cloud platform.
This is only needed when you are using MSK’s SASL IAM based authentication (port 9098), for SASL SCRAM based authentication.

## Module details

### IAM Role

The DeltaStream platform uses the IAM role created with this module to assume role and connect to your MSK.
Only IAM roles with `DeltaStream` term present within the name are allows. Eg: `arn:aws:iam::123456789012:role/AcmeSiteDeltaStreamMSKRole`.
This Naming convention design helps to ensure that DeltaStream platform will not assume any other role in customers' AWS account hosting MSK or AWS Kinesis streams.

Variables:

* `deltastream_account_id`: This is the DeltaStream account ID. Please contact support@deltastream.io for this number.
* `deltastream_organization_id`: This is the UUID for your Organziation on DeltaStream. You can obtain this by running `LIST ORGANIZATIONS;` via the CLI or by
navigating to `Settings -> Organizations` on the Webapp.

### IAM Policy

The IAM Policy attach to the role defines the privileges granted to the role on your MSK. You can control the prefix of topic that you want to allow DeltaStream to
read, write & alter, create and delete.

Variables:
* `msk_region`: This is the AWS region hosting your MSK.
* `msk_cluster_name`: This is the name of your MSK Cluster. E.g. For an ARN arn:aws:kafka:us-west-2:123456789012:cluster/my-msk-123/ffab6be5-b41a-cc33-8e23-90098cbbde86-10, the cluster name is my-msk-123.
* `msk_cluster_id`: This is the unique identifier found as a suffix within MSK Cluster ARN. E.g. For an ARN arn:aws:kafka:us-west-2:123456789012:cluster/my-msk-123/ffab6be5-b41a-cc33-8e23-90098cbbde86-10, the cluster id is ffab6be5-b41a-cc33-8e23-90098cbbde86-10.
* `read_topic_prefix`: This specifies the topic prefix allowed for read operations. An empty string will allow all topics to be read.
* `write_topic_prefix`: This specifies the topic prefix allowed for write and alter operations. An empty string will allow write to any topics.
* `create_topic_prefix`: This specifies the topic prefix allowed for topic creation operations. An empty string will allow creation of topics with any name.
* `delete_topic_prefix`: This specifies the topic prefix allowed for topic deletion operations.An empty string will allow deletion of any topics.
