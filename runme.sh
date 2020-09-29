#!/bin/bash 
# Include Other Script Files
source scripts/vpc-rds-create.sh
source scripts/runtf.sh

echo "===================="
echo "DevOps Simple Deploy"
echo "===================="

#dialog --clear --backtitle "Backtitle here" --title "Title here" --menu "Choose one of the following options:" 15 40 4 \
#1 "Option 1" \
#2 "Option 2" \
#3 "Option 3"

PS3='Please enter your choice: '
options=("Option 1 Local" "Option 2 VPC and RDS" "Option 3 EKS Cluster" "Option 4 Deploy in EKS" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1 Local")
            echo "Create Local Image and Deploy"
            ;;
        "Option 2 VPC and RDS")
            echo "Create VPC and RDS in AWS"
            infracreate 
            ;;
        "Option 3 EKS Cluster")
            echo "Create and Deploy in EKS"
            ;;
        "Option 4 Deploy in EKS")
            echo "Deploy in EKS Cluster"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


