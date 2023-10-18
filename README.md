
# Terraform-config-vpc-aws
Create Virtual Private Cloud in AWS with Terraform module.

**This pic details clearly about the VPC and subnet are being used in this project
![aws_subnet](https://github.com/Thanhlam43k4/Terraform-config-vpc-aws/assets/122345050/65423aaa-07fd-47e4-a26b-dce699a151f5)

<img src= "https://github.com/Thanhlam43k4/Terraform-config-vpc-aws/assets/122345050/74c7f868-dc72-47bc-ad63-0c4b45db6419" width = "700"/>  


Steps to create Basic VPC in Amazon Web service use Terraform. 

**Properties:

    - 1 VPC in ap-northeast-1 region with crid_block : "10.0.0.0/16".

    - 4 subnet with 2 public and 2 private:

      +Public: ["10.0.5.0/24","10.0.6.0/24"]

      +Private: ["10.0.7.0/24","10.0.8.0/24"]

      +Zone: ["ap-northeast-1a","ap-northeast-1c"]

    - 1 aws_internet_gateway: For subnet can access to Internet.

    - 2 route_table: To route from public subnet to aws_internet_gateway.

    
