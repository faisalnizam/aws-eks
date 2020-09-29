#!/bin/bash 

# Do A Local Deployment Using Docker-Compose
function deploylocal {


    cdir=`pwd` 
    cd $cdir/local 

    docker-compose build



}
