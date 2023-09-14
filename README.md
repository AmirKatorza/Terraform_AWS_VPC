# Terraform AWS Infrastructure

This Terraform project sets up a basic AWS infrastructure, which includes:

- A VPC with associated subnets.
- Two EC2 instances across two different availability zones.
- An Application Load Balancer (ALB) that balances traffic between the two EC2 instances.
- Necessary security groups and routing configurations.

## Architecture

- **VPC (`amirk-tf-vpc`)**: A Virtual Private Cloud with CIDR block `10.0.0.0/16`.
  
- **Subnets**: Two public subnets in two different availability zones (`us-east-1a` and `us-east-1b`), facilitating high availability.

- **EC2 Instances**: Two `t3.micro` EC2 instances, one in each subnet. They serve as the targets for our ALB.

- **ALB (`amirk-tf-alb`)**: An Application Load Balancer that listens on ports 80 (HTTP) and 443 (HTTPS) and routes traffic to the EC2 instances.

- **Security Group (`amirk-tf-sg`)**: Defines the ingress and egress rules for our EC2 instances and ALB.

- **Key Pair (`amirk-auth`)**: An SSH key pair for accessing the EC2 instances.

## How to Use

1. **Initialize Terraform**:
   This step initializes the working directory containing Terraform configuration files. It's the first command that should be run after writing a new Terraform configuration.
   ```
   terraform init
2. **Plan Your Changes**:
   The `plan` command lets you see which actions Terraform will perform prior to making any changes, allowing for a kind of "dry run" of Terraform executions.
   ```
   terraform plan
3. **Apply Your Changes**:
   The `apply` command executes the actions proposed in the Terraform plan. This is the command that actually provisions resources or makes changes to existing ones.
   ```
   terraform apply

# ⚠️ Cost Warning
Running the infrastructure set up by this Terraform project may incur expenses in your AWS account. 
AWS charges for the resources and services used, such as EC2 instances, data transfer, and the Application Load Balancer. 
Before applying the Terraform configurations, ensure you understand the costs associated with each resource and that you monitor usage to avoid any unexpected charges. 
Always remember to destroy resources you no longer need using `terraform destroy` to prevent ongoing charges.

    
