# OpenSSL self-managed Certificate Authority

__Notice:__ If you are looking for a way to use SSL certs on public host addresses, please consider using [Let's Encrypt](https://letsencrypt.org/) project! It's free, it's automated and is already trused by common browsers so you won't have to manipulate user's certificates chain of trust. For private addresses (ie: `myhost`, `myhost.mydomain`, `10.0.0.1`, etc) Let's Encrypt won't help you so this project could be very useful.

## Description

Tired of really-complicated-stuff on internet about how to create and maintain self-managed certificates?
Me too! That's why I've created this simple project to:

1. Provide sane defaults (`rsa`/`sha256`/`2048` bits keys) via a config file (`openssl.conf`)
2. Provide a script (`create_ca_key.sh`) to create your own Certificate Authority to sign certificates
3. Provide a script (`create_csr.sh`) to create keys and certificate signing requests (CSR) for your apps
4. Provide a script (`sign_csr.sh`) to sign your CSRs
5. Provide a script (`combine_csr.sh`) to combine key + crt to create a pem file and combine crt + CA.crt to create chained.crt file
6. Provide a script (`getbase64_tar.sh`) to generate a base64 of the tar compressed files and scripts to update the cert in the server (formats available PEM and NGINX)
7. Provide a script (`create_crt.sh`) to perform (3), (4), (5) and (6) in one step.

## Getting started

1. __Clone this repo__
2. __Run `create_ca_key.sh`__ to create your root CA certificate and private key. The root CA certificate will be stored on the `./CA` folder named `ca.crt` and the private key will be stored in `./CA/private/ca.key`. You should call this script only once, as it will overwrite any existing CA key and CA certificate already present on the repo.
3. __Create and sign as many certificates you want__, using `create_crt.sh <app_name>`. The key, CSR and certificate generated will be stored as `./out/<app_name>.<key|csr|crt>`.
4. __Ready!__ You can use your app-specific keys and certificates on your apps. If you want to trust these certificates you should add `./CA/ca.crt` onto your local storage of trusted certificates (on Ubuntu this can be done by copying the file to `/usr/local/share/ca-certificates/` and running `update-ca-certificates`). The nice thing is that what you are really doing is to build your own chain of trust, managed by you.

__Warning__: Adding `ca.crt` to your list of trusted CA means that your PC will trust any certificate signed by `./CA/private/ca.key` .  This could be used to impersonate any website on PCs that trust this cert so __keep this key private!!__ (Ideally offline)

## Being your own CA

The `openssl.conf` file manages various defaults for cert creation. I tried to not include insane parameters but you should really look them to check if those match your definition of sanity.

It is also possible to uncomment the Defaults (under the `req_distinguished_name` section) if you want to save some keystrokes by pre-completing some boring cert fields.

## References:
1. [SSL certs in debian-administration](http://www.debian-administration.org/article/284/Creating_and_Using_a_self_signed__SSL_Certificates_in_debian)
2. [Installing a SSL cert on Ubuntu](http://askubuntu.com/questions/73287/how-do-i-install-a-root-certificate)
3. [OpenSSL sample minimal CA app](https://www.openssl.org/docs/apps/ca.html)
4. [OpenSSL Certificate Authority](https://jamielinux.com/docs/openssl-certificate-authority/introduction.html)
5. [How to setup your own CA with OpenSSL](https://gist.github.com/Soarez/9688998)
