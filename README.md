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

 CONFIGURATION
-------------

 * Configure the user permissions in Administration » People » Permissions:

   - Use the administration pages and help (System module)

     The top-level administration categories require this permission to be
     accessible. The administration menu will be empty unless this permission
     is granted.

   - Access administration menu

     Users with this permission will see the administration menu at the top of
     each page.

   - Display links

     Users with this permission will receive links to drupal.org issue queues
     for all enabled contributed modules. The issue queue links appear under
     the administration menu icon.

 * Customize the menu settings in Administration » Configuration and modules »
   Administration » Administration menu.

 * To prevent administrative menu items from appearing twice, you may hide the
   "Management" menu block.


