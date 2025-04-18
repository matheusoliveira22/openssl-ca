#! /bin/bash

if [[ $# -eq 0 ]]
then
	echo "Usage: create_crt <APP_NAME>"
	echo "Example: create_crt myapp"
else
	./create_csr.sh $1 &&
	./sign_csr.sh $1 &&
	./combine_csr.sh $1 &&
	./getbase64_tar.sh $1 PEM &&
	./getbase64_tar.sh $1 NGINX
fi
