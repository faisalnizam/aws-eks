
----------------------
Command Line Arguments
----------------------

Example:  ./runme.sh  < textfile

Options 1 | 2 | 3 | 4 
  (required) Specifies the type of deployment (local, aws, eks) 

    -1 - Install Locally using docker-compose 
    -2 - Create VPC and RDS (Individually or Together Using Terraform)
    -3 - Create EKS Cluster on AWS Using Terraform
    -4 - Deploy on EKS Cluster, Specify Namespace
