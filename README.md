

## Terraform Infrastructure Deployment

This repository contains Terraform scripts to deploy a resilient AWS infrastructure. The setup includes a VPC with two subnets, an auto-scaling group of EC2 instances behind a load balancer, and necessary configurations to ensure the load balancer returns the AWS instance IP's when accessed.

**Overview**

1. VPC Creation: A VPC with CIDR 17.1.0.0/25 is created.
2. Subnets: Two subnets in different availability zones.
3. Load Balancer: An ELB with auto-scaling of EC2 instances.
4. EC2 Instances: Two EC2 instances (one in each subnet) with autoscaling to a total of five instances.
5. User Data: Each instance runs a script to install Apache, set up a simple HTML page with the instance ID, and make it available through the ELB.

**Prerequisites**

1. Terraform: Ensure Terraform is installed on your machine. You can download it from Terraform's official website.
2. AWS CLI: Install and configure AWS CLI with your AWS credentials:
```
aws configure
```
```
unzip option1
cd option1
```
**Setup Variables**
Update the terraform.tfvars file in the root directory of the repository with the following content. Replace placeholders with your AWS account ID and region:

```
aws_account_id = "<your-aws-account-id>"
region          = "us-east-1"
```
## Deployment Steps

1. **Initialize Terraform**

```
terraform init
```
2. **Plan your aws infra**
```
terraform plan
```
3. **Apply Configuration**
```
terraform apply
```
Confirm the apply action when prompted. Terraform will create the infrastructure as specified.
Accessing the Load Balancer

After deployment, Terraform will output the **DNS name** of the load balancer.
Open a web browser and navigate to the provided ELB URL.
You should see a page displaying "Hello World from [Instance-IP]". 

Refreshing the page will show different instance IP as the load balancer distributes requests among instances.
# aws-terraform-infra
