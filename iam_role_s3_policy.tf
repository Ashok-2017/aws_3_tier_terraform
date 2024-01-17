provider "aws" {
  region = "us-west-1"
  access_key = "my-access-key"
  secret_key = "my-sectret-key"
}

export AWS_ACCESS_KEY_ID = "my-access-key"
export AWS_SECRET_ACCESS_KEY = "my-secret-key"
export AWS_REGION = "us-west-1"

terraform {
  required_providers {
    aws = {
     source = "hashicorp/aws"
     version = "~>4.0"
}
}
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_iam_role" "astro_role" {
  name = "astro_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
       "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com" 
          },
          "Action": "sts:AssumeRole"
       }
     ]
}
EOF
}

resource "aws_iam_policy_attachment" "attachment" {
  role = aws_iam_role.astro_role.name
  policy_arn = "arn:aws:iam:aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "astro_profile" {
  name = "astro_profile"
  role = aws_iam_role.astro_role.name
}

resource "aws_instance" "astro_instance" {
  ami = " "
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.astro_profile.name

  tags = {
    Name = "astroinstance"
  }

resource "aws_s3_bucket_policy" "astro_bucket_policy" {
  bucket = "astro_bucket"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.astro_role.name}"
          },
           "Action": [
              "s3: GetObject", 
              "s3: ListBucket"
           ],
           "Resource": [
          "arn:aws:s3:::astro_bucket",
          "arn:aws:s3:::astro_bucket/*"
        ]
      }
    ]
  })
}

data "aws_caller_identity" "current" { }


# Add the provider block to declare we will use the AWS provider and set the region (us-east-1 in the example is North Virginia).
# Create an IAM role named “example-role” using the aws_iam_role resource. The assume_role_policy attribute specifies the trust policy, allowing EC2 instances to assume this role.
# Attach an AWS-managed policy, “AmazonS3ReadOnlyAccess,” to the role using the aws_iam_role_policy_attachment resource.
# Create the EC2 instance using the aws_instance resource. The ami attribute is set to the desired Amazon Machine Image (AMI) ID. The AMI used in the example is an Amazon Linux 2023 AMI eligible for the free tier at the time of writing.To check available AMIs, log into the console at https://console.aws.amazon.com/ec2/ and click on ‘AMI Catlog’ under the Instances section.

  













