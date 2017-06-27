#!/bin/bash

<<COMMENT
@author: jaymiao
@date: 2017-06-27
@description: create project doxygen doc
COMMENT

path=$(readlink -f $0)
dir=$(dirname $path);

project=$1
input=$2

if [ "$project" == "" ]; then
    echo "usage ./create.sh project_name input_file_dir "
    echo "project_name is empty"
    exit
fi

if [ "$input" == "" ]; then
    echo "usage ./create.sh project_name input_file_dir "
    echo "input_file_dir is empty"
    exit
fi

if [ ! -d "$input" ]; then
    echo "usage ./create.sh project_name input_file_dir "
    echo "$input is not exist"
    exit
fi

cp doxygen.conf.template doxygen.conf

sed -i "s#<PROJECT_NAME>#$project#g" doxygen.conf
sed -i "s#<INPUT_PROJECT>#$input#g" doxygen.conf

rm -rf $project

doxygen -s doxygen.conf

#change dirname to ''
sed -i "s#$input##g" ./${project}/html/*.html 
