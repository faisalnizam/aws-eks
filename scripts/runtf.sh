#! /bin/bash

function runtf {


    cd $directory 
    cdir=pwd 
    echo ""
    echo "Current directory is $cdir"

    #Initialize Terraform 
    terraform init 

    #Create Terraform Plan 
    terraform plan 

}
