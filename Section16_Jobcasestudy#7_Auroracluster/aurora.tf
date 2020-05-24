data "aws_availability_zones" "available" {
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = var.CLUSTER_IDENTIFIER
  engine                  = "aurora-mysql"
  engine_version          = "5.7.12"
  availability_zones      = data.aws_availability_zones.available.names
  database_name           = var.DATABASE_NAME
  master_username         = var.MASTER_USERNAME
  master_password         = var.MASTER_PASSWORD
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = "true"
  apply_immediately       = "true"
  vpc_security_group_ids  = [var.VPC_SECURITY_GROUP_IDS]
  db_subnet_group_name    = var.DB_SUBNET_GROUP_NAME
  tags = {
    Name        = "${var.ENVIRONMENT_NAME}-Aurora-DB-Cluster"
    ManagedBy   = var.MANAGER
    Environment = var.ENVIRONMENT_NAME
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = var.INSTANCE_COUNT_IN_CLUSTER
  identifier         = "${var.CLUSTER_IDENTIFIER}-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = var.DB_INSTANCE_CLASS
  engine             = "aurora-mysql"

  tags = {
    Name        = "${var.ENVIRONMENT_NAME}-aurora-instance-${count.index}"
    ManagedBy   = var.MANAGER
    Environment = var.ENVIRONMENT_NAME
  }
}

output "Cluster_Endpoint" {
  value = aws_rds_cluster.default.endpoint
}

output "Cluster_Instance_Endpoints" {
  value = aws_rds_cluster_instance.cluster_instances.*.endpoint
}

output "Reader_Endpoint" {
  value = aws_rds_cluster.default.reader_endpoint
}

