#!/bin/bash

# Decompress with echo "base64_encoded_string" | base64 --decode > cert.tar.gz && tar -xvzf cert.tar.gz

if [[ $# -le 1 ]]
then
	echo "Usage: getbase64_tar <APP_NAME> <FORMAT>"
	echo "Example: getbase64_tar APP_NAME PEM"
	echo "Available formats: PEM, NGINX"
else
	cd out
	case "${2}" in
	    "PEM")
	    	tar -czvf ${1}.tar.gz ${1}.pem
	    	;;
	    "NGINX")
	    	tar -czvf ${1}.tar.gz ${1}.chained.crt ${1}.key
	    	;;
	    *)
	    	echo "Format provided '${2}' invalid!"
		exit 1
		;;
	esac
	echo ""
	echo "=== BASE64 ${2} BEGIN  ==="
	base64 -w 0 ${1}.tar.gz
	echo ""
	echo "=== BASE64 ${2} END    ===" 
	echo ""
	echo "=== Commands to run in server - ${2} ==="
	echo "BASE64_TARGZ_CERT=\"$(base64 -w 0 ${1}.tar.gz)\""
	echo "echo \"\$BASE64_TARGZ_CERT\" | base64 --decode > cert.tar.gz && tar -xvzf cert.tar.gz && rm cert.tar.gz"
	if [ ${2} = "NGINX" ]; then
		echo "sudo cp ${1}.chained.crt /etc/ssl/certs"
		echo "sudo cp ${1}.key /etc/ssl/certs"
		echo "sudo chmod 755 /etc/ssl/certs/${1}.*"
		echo "sudo chown www-data:www-data /etc/ssl/certs/${1}.*"
		echo "rm ${1}.chained.crt"
		echo "rm ${1}.key"
	fi
	echo "=== Commands to run in server - ${2} - Finish ==="
fi
