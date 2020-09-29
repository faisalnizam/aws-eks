#!/bin/bash 
source scripts/runtf.sh 

# Create AWS Infrastructure Using Terraform 

function infracreate {

    pkg=terraform
    which terraform > /dev/null 2>&1
    

    if [ $? == 0 ]
    then
            echo ""
            echo "$pkg is already installed. "
            echo ""
    else
            echo "$pkg is not installed."
            echo "Cannot Continue"
            exit
    fi 


title="Create Infra"
prompt="Pick an option, Press Enter To Print Meby Again :"
options=("vpc" "rds" "all")

echo "$title"
PS3="$prompt "
select opt in "${options[@]}" "Quit"; do 

    case "$REPLY" in

        1 ) echo "You picked $opt which is create $REPLY"
            echo ""
            directory="terraform/env/dev/vpc/"
            runtf
        ;;
        2 ) echo "You picked $opt which is create $REPLY"
            echo ""
            directory="terraform/env/dev/rds/"
            runtf
        ;;
        3 ) echo "You picked $opt which is create $REPLY"
            echoi ""
            directory="terraform/env/dev/vpc/"
            runtf
            directory="terraform/env/dev/rds/"
            runtf
        ;;
    $(( ${#options[@]}+1 )) ) echo "Exiting!"; break;;
    *) echo "Invalid option..";continue;;

    esac

done


while opt=$(zenity --title="$title" --text="$prompt" --list \
                    --column="Options" "${options[@]}"); do

    case "$opt" in
    "${options[0]}" ) zenity --info --text="You picked $opt, option 1";;
    "${options[1]}" ) zenity --info --text="You picked $opt, option 2";;
    "${options[2]}" ) zenity --info --text="You picked $opt, option 3";;
    *) zenity --error --text="Invalid option. Try another one.";;
    esac

done



}



