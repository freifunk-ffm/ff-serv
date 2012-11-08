#!/bin/bash
UPLOAD_URL="http://127.0.0.1:3000/tincs.txt"
CURLC=`which curl`
TINC_NAME="a82a142cf677"
CERT_FILE="./dummy_cert.asc"


#for cnt in $(seq 1 100);
#do
        $CURLC -k -F "cert=@$CERT_FILE" $UPLOAD_URL -u $TINC_NAME:$TINC_NAME
#        sleep 10
#done
