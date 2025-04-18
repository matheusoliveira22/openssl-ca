#!/bin/bash

if [[ $# -eq 0 ]]
then
	echo "Usage: combine_csr <APP_NAME>"
	echo "Example: combine_csr myapp"
else
	cat ./out/${1}.key ./out/${1}.crt > ./out/${1}.pem
	cat ./out/${1}.crt ./CA/ca.crt > ./out/${1}.chained.crt
fi
