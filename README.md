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


CONTENTS OF THIS FILE
---------------------

 * Introduction
 * Requirements
 * Recommended modules
 * Installation
 * Configuration
 * Troubleshooting
 * FAQ
 * Maintainers


 INTRODUCTION
------------

The RunMe Script displays the entire administrative menu tree. The Purpose of the Program is 
to have a single place where all general DevOps Practices are utilized and can be reused. 
The Script can easily be modified using own options to deploy own Artifcats. 

Moveover The Script can easily be modified to accept Command Line Inputs or STDIN to incorporate within any pipeline easily

 * For a full description of the module, visit the project page:
   https://www.devops.ae/project/bash

 * To submit bug reports and feature suggestions, or track changes:
    faisal@devops.ae

REQUIREMENTS
------------

This module requires the following modules:

 * Hashicorp Terraform (https://www.terraform.io/)
 * Ansible  (https://www.ansible.com)
 * Hashicorp Packer  (https://www.packer.io/) 
 * Docker Engine (https://docs.docker.com/engine/install/) 
 * AWS (https://aws.amazon.com/)

