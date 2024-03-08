{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kafka-cluster:Connect"
            ],
            "Resource": [
                "arn:aws:kafka:${region}:${aws_account_id}:cluster/${msk_cluster_name}/${msk_cluster_id}"
            ],
            "Sid": "kafkaConnectStatement"
        },
        {
            "Action": [
                "kafka-cluster:ReadData",
                "kafka-cluster:DescribeTopic*"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:kafka:${region}:${aws_account_id}:topic/${msk_cluster_name}/${msk_cluster_id}/${read_topic_prefix}*"
            ],
            "Sid": "kafkaReadTopicStatement"
        },
        {
            "Action": [
                "kafka-cluster:*Group"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:kafka:${region}:${aws_account_id}:group/${msk_cluster_name}/${msk_cluster_id}/*",
            "Sid": "kafkaGroupStatement"
        },
        {
            "Action": [
                "kafka-cluster:AlterTransactionalId",
                "kafka-cluster:DescribeTransactionalId"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:kafka:${region}:${aws_account_id}:transactional-id/${msk_cluster_name}/${msk_cluster_id}/*",
            "Sid": "kafkaExactlyOnceTxStatement"
        },
        {
            "Action": [
                "kafka-cluster:WriteData",
                "kafka-cluster:DescribeTopic*",
                "kafka-cluster:AlterTopic*"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:kafka:${region}:${aws_account_id}:topic/${msk_cluster_name}/${msk_cluster_id}/${write_topic_prefix}*"
            ],
            "Sid": "kafkaWriteTopicStatement"
        },
        {
            "Action": [
                "kafka-cluster:AlterTransactionalId",
                "kafka-cluster:DescribeTransactionalId"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:kafka:${region}:${aws_account_id}:transactional-id/${msk_cluster_name}/${msk_cluster_id}/*",
            "Sid": "kafkaWriteExactlyOnceTxStatement"
        },
        {
            "Effect": "Allow",
            "Action": [
                "kafka-cluster:WriteDataIdempotently"
            ],
            "Resource": [
                "arn:aws:kafka:${region}:${aws_account_id}:cluster/${msk_cluster_name}/${msk_cluster_id}"
            ],
            "Sid": "kafkaClusterWriteIdempotent"
        },
        {
            "Sid": "createKafkaTopicPermissions",
            "Action": [
                "kafka-cluster:CreateTopic"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:kafka:${region}:${aws_account_id}:topic/${msk_cluster_name}/${msk_cluster_id}/${create_topic_prefix}*"
            ]
        },
        {
            "Sid": "deleteKafkaTopicPermissions",
            "Action": [
                "kafka-cluster:DeleteTopic"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:kafka:${region}:${aws_account_id}:topic/${msk_cluster_name}/${msk_cluster_id}/${delete_topic_prefix}*"
            ]
        }
    ]
}
