terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. Batch Worker EC2 Instance (Oversized Compute)
resource "aws_instance" "analytics_batch_worker" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "m5.large" # FinOps Downsized from c5.large # FinOps Downsized from c5.4xlarge

  tags = {
    Name        = "analytics-batch-worker-prod"
    Environment = "Production"
    Project     = "DataAnalytics"
  }
}

# 2. Internal Dashboard EC2 (Oversized Compute)
resource "aws_instance" "internal_dashboard" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "m5.2xlarge"

  tags = {
    Name        = "internal-tooling-dashboard"
    Environment = "Internal"
  }
}

# 3. Unattached Migration EBS Volume (Unattached Storage Waste)
# [FINOPS-REMOVED-UNATTACHED-VOLUME] # [FINOPS-REMOVED-UNATTACHED-VOLUME] resource "aws_ebs_volume" "backup_migration_temp" {
# [FINOPS-REMOVED-UNATTACHED-VOLUME] # [FINOPS-REMOVED-UNATTACHED-VOLUME]   availability_zone = "us-east-1a"
# [FINOPS-REMOVED-UNATTACHED-VOLUME] # [FINOPS-REMOVED-UNATTACHED-VOLUME]   size              = 500
# [FINOPS-REMOVED-UNATTACHED-VOLUME] # [FINOPS-REMOVED-UNATTACHED-VOLUME]   type              = "gp3"
# [FINOPS-REMOVED-UNATTACHED-VOLUME] # [FINOPS-REMOVED-UNATTACHED-VOLUME] 
# [FINOPS-REMOVED-UNATTACHED-VOLUME] # [FINOPS-REMOVED-UNATTACHED-VOLUME]   tags = {
# [FINOPS-REMOVED-UNATTACHED-VOLUME] # [FINOPS-REMOVED-UNATTACHED-VOLUME]     Name    = "backup-volume-migration-temp"
# [FINOPS-REMOVED-UNATTACHED-VOLUME] # [FINOPS-REMOVED-UNATTACHED-VOLUME]     Purpose = "OldDatabaseMigration"
# [FINOPS-REMOVED-UNATTACHED-VOLUME] # [FINOPS-REMOVED-UNATTACHED-VOLUME]   }
# [FINOPS-REMOVED-UNATTACHED-VOLUME] }
# [FINOPS-REMOVED-UNATTACHED-VOLUME] 
# [FINOPS-REMOVED-UNATTACHED-VOLUME] # 4. Legacy Log EBS Volume (Unattached Storage Waste)
# [FINOPS-REMOVED-UNATTACHED-VOLUME] resource "aws_ebs_volume" "legacy_log_volume" {
# [FINOPS-REMOVED-UNATTACHED-VOLUME]   availability_zone = "us-east-1a"
# [FINOPS-REMOVED-UNATTACHED-VOLUME]   size              = 250
# [FINOPS-REMOVED-UNATTACHED-VOLUME]   type              = "gp2"
# [FINOPS-REMOVED-UNATTACHED-VOLUME] 
# [FINOPS-REMOVED-UNATTACHED-VOLUME]   tags = {
# [FINOPS-REMOVED-UNATTACHED-VOLUME]     Name        = "legacy-log-volume"
# [FINOPS-REMOVED-UNATTACHED-VOLUME]     Environment = "Legacy"
# [FINOPS-REMOVED-UNATTACHED-VOLUME]   }
}

# 5. Idle Serverless Lambda Function (Idle Serverless Waste)
resource "aws_lambda_function" "legacy_image_resizer" {
  function_name = "legacy-image-resizer"
  runtime       = "python3.9"
  handler       = "index.handler"
  role          = "arn:aws:iam::123456789012:role/lambda-role"
  filename      = "dummy_lambda.zip"
  memory_size   = 1024

  tags = {
    Deprecated = "true"
  }
}

# 6. Unassociated Elastic IP (Idle Networking Waste)
# [FINOPS-RELEASED-UNASSOCIATED-EIP] resource "aws_eip" "unassociated_ip" {
# [FINOPS-RELEASED-UNASSOCIATED-EIP]   domain = "vpc"
# [FINOPS-RELEASED-UNASSOCIATED-EIP] 
# [FINOPS-RELEASED-UNASSOCIATED-EIP]   tags = {
# [FINOPS-RELEASED-UNASSOCIATED-EIP]     Name = "unassociated-elastic-ip-1"
# [FINOPS-RELEASED-UNASSOCIATED-EIP]   }
}
