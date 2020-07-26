#!/bin/bash
mkdir certs
pushd certs
ip -o -4 addr list | awk '{print $4}' | cut -d "/" -f 1 > allIPs
IFS=$'\r\n' command eval 'allIPsArray=($(cat allIPs))'
mkcert -key-file key.pem -cert-file cert.pem localhost developermachine "${allIPsArray[@]}"
popd

echo 0