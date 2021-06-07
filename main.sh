#!/bin/bash

source components/common.sh

COMPONENT=$1

export LOG=/tmp/${COMPONENT}.log
rm -f $LOG

if [ ! -f components/$1.sh ]; then
  ERROR "Invalid component name is provided"
  exit 1
fi


USER_NAME=$(whoami)
if [ "${USER_NAME}" != "root" ]; then
  ERROR "you should be a root user to perform this script ,try with sudo"
  exit 1
fi

export COMPONENT
bash components/${COMPONENT}.sh
