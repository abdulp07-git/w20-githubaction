provider "aws" {
  region = "ap-south-1"
}

module "networking" {
  source = "./networking"
}

module "securityGroup" {
  source = "./security"
  vpc_id = module.networking.vpc_id
  publicSubnetID = module.networking.publicSubnet
  publicSubnetcidr = module.networking.publicSubnetcidr
}

module "server" {
  source = "./servers"
  vpc_id = module.networking.vpc_id
  publicSubnet = module.networking.publicSubnet
  securityGroup = module.securityGroup.securityGroup
}


resource "aws_s3_bucket" "w20tfbackend" {
    bucket = "w20tfbackend"
}

resource "aws_s3_bucket_public_access_block" "w20tfbackend_public_access" {
  bucket                  = aws_s3_bucket.w20tfbackend.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "w20tfbackendversion" {
  bucket = aws_s3_bucket.w20tfbackend.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_policy" "w20tfbackend_policy" {
  bucket = aws_s3_bucket.w20tfbackend.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Principal = "*"
        Action   = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.w20tfbackend.arn}/*"
      }
    ]
  })
}



resource "aws_dynamodb_table" "w20tf_state_lock_table" {
  name = "w20tf_state_lock_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "w20tf_state_lock_table"
  }
}


terraform {
  backend "s3" {
    bucket = "w20tfbackend"
    key = "terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    dynamodb_table = "w20tf_state_lock_table"

  }
}
