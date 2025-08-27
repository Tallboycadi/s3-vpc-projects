# AWS S3 VPC Endpoint Projects

# AWS VPC + S3 + (Free-Tier) EC2 — with Terraform

[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.5-844FBA?logo=terraform)]()
[![AWS](https://img.shields.io/badge/AWS-us--east--1-FF9900?logo=amazon-aws&logoColor=fff)]()

**What I built:**  
- VPC with 2 public subnets, Internet Gateway, and route tables  
- Gateway VPC Endpoints (S3, DynamoDB) — *free*  
- S3 bucket for app/data artifacts  
- EC2 (t3.micro) registered with SSM (free-tier eligible)

**Why it matters (DevOps value):**  
- Infra-as-code (repeatable, auditable)  
- Private service access via Gateway Endpoints (no NAT)  
- Clean repo & Git workflow (.gitignore, lockfile tracked)

---

## Architecture

```mermaid

flowchart TB
  Dev[Developer<br/>
  VS Code + Terraform] -->|apply| AWS[(AWS Account)]

  subgraph VPC["VPC 10.20.0.0/16"]
    direction TB
    IGW[Internet Gateway]
    RTpub[Public Route Table]
    SubA[Public Subnet A<br/>10.20.1.0/24]
    SubB[Public Subnet B<br/>10.20.2.0/24]
    EC2[EC2 t3.micro
    (SSM Agent)]
  end

  SSM_SVC[(AWS Systems Manager)]
  S3[(Amazon S3)]
  DDB[(Amazon DynamoDB)]
  GWE[Gateway Endpoints<br/>S3 + DynamoDB]

  EC2 -- SSM --> SSM_SVC
  RTpub --> IGW

  SubA -.-> GWE
  SubB -.-> GWE
  GWE -.-> S3
  GWE -.-> DDB


# clone
git clone https://github.com/Tallboycadi/s3-vpc-projects.git
cd s3-vpc-projects

# set AWS creds (profile or keys) & region
export AWS_PROFILE=clif-keys
export AWS_REGION=us-east-1

# init → plan → apply
terraform init -upgrade
terraform fmt -recursive
terraform validate
terraform plan -out tfplan
terraform apply tfplan

