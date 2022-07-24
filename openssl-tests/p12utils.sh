#!bin/sh

set -eux

#openssl pkcs12 -in files/badssl.com-client.p12 -passin pass:badssl.com -nokeys -clcerts -legacy
#openssl pkcs12 -in files/badssl.com-client.p12 -passin pass:badssl.com -nokeys -cacerts -legacy
#openssl pkcs12 -in files/badssl.com-client.p12 -passin pass:badssl.com -nocerts -passout pass: -legacy

##Test connection with extracted certs
#curl -v https://badssl.com --cert out/cert.pem --key out/key-with-pass.pem --pass testpass
#openssl s_client -connect badssl.com:443 -cert out/cert.pem -key out/key.pem

#Usage - sh p12utils.sh getcert files/badssl.com-client.p12 ./out/cert.pem badssl.com -legacy
getcert() {

	if [ -z ${1+x} ]; then echo "Please provide input p12 path. Usage getcert <inp12path> <outpath> <inputpassword>"; exit 1; fi
	if [ -z ${2+x} ]; then echo "Please provide output cert path. Usage getcert <inp12path> <outpath> <inputpassword>"; exit 1; fi
	if [ -z ${3+x} ]; then echo "Please provide inpwd cert path. Usage getcert <inp12path> <outpath> <inputpassword>"; exit 1; fi

    inpath="$1"
    outpath="$2" 
    inpwd="$3"
    extraargs=$(echo "$@" | cut -d ' ' -f 4-)

    dir=$(dirname $2)
    if [ $dir != "." ] && [ ! -d $dir ]; then mkdir -p $dir; fi 

    command="openssl pkcs12 -nokeys -in ${inpath} -out ${outpath} -passin pass:${inpwd} ${extraargs}"
    echo $command
    $command
}

#Usage - sh p12utils.sh getkey files/badssl.com-client.p12 ./out/key.pem badssl.com -legacy
getkey() {
	if [ -z ${1+x} ]; then echo "Please provide input p12 path. Usage getkey <inp12path> <outpath> <inputpassword>"; exit 1; fi
	if [ -z ${2+x} ]; then echo "Please provide output cert path. Usage getkey <inp12path> <outpath> <inputpassword>"; exit 1; fi
	if [ -z ${3+x} ]; then echo "Please provide inpwd cert path. Usage getkey <inp12path> <outpath> <inputpassword>"; exit 1; fi

    inpath="$1"
    outpath="$2" 
    inpwd="$3"
    extraargs=$(echo "$@" | cut -d ' ' -f 4-)

    dir=$(dirname $2)
    if [ $dir != "." ] && [ ! -d $dir ]; then mkdir -p $dir; fi 

    command="openssl pkcs12 -nocerts -in ${inpath} -out ${outpath} -passin pass:${inpwd} -passout pass: ${extraargs}"
    echo $command
    $command
    openssl rsa -in ${outpath} -out ${outpath} -passin pass:
}

#Usage - sh p12utils.sh getkeywithpass files/badssl.com-client.p12 ./out/key.pem badssl.com testpass -legacy
getkeywithpass() {
	if [ -z ${1+x} ]; then echo "Please provide input p12 path. Usage getkeywithpass <inp12path> <outpath> <inputpassword> <outpassword>"; exit 1; fi
	if [ -z ${2+x} ]; then echo "Please provide output cert path. Usage getkeywithpass <inp12path> <outpath> <inputpassword> <outpassword>"; exit 1; fi
	if [ -z ${3+x} ]; then echo "Please provide inpwd cert password. Usage getkeywithpass <inp12path> <outpath> <inputpassword> <outpassword>"; exit 1; fi
	if [ -z ${4+x} ]; then echo "Please provide out key password. Usage getkgetkeywithpassey <inp12path> <outpath> <inputpassword> <outpassword>"; exit 1; fi


    inpath="$1"
    outpath="$2" 
    inpwd="$3"
    outpwd="$4"
    extraargs=$(echo "$@" | cut -d ' ' -f 5-)

    dir=$(dirname $2)
    if [ $dir != "." ] && [ ! -d $dir ]; then mkdir -p $dir; fi 

    command="openssl pkcs12 -nocerts -in ${inpath} -out ${outpath} -passin pass:${inpwd} -passout pass:${outpwd} ${extraargs}"
    echo $command
    $command
}

#Usage - sh p12utils.sh topemwithpass files/badssl.com-client.p12 ./out/certandkey.pem badssl.com -legacy
#sh p12utils.sh topem out/top12.p12 out/backtopem.pem testpass
topem() {
	if [ -z ${1+x} ]; then echo "Please provide input p12 path. Usage topem <inp12path> <outpath> <inputpassword> "; exit 1; fi
	if [ -z ${2+x} ]; then echo "Please provide output cert path. Usage topem <inp12path> <outpath> <inputpassword>"; exit 1; fi
	if [ -z ${3+x} ]; then echo "Please provide input password. Usage topem <inp12path> <outpath> <inputpassword> "; exit 1; fi


    inpath="$1"
    outpath="$2" 
    inpwd="$3"
    extraargs=$(echo "$@" | cut -d ' ' -f 4-)

    dir=$(dirname $2)
    if [ $dir != "." ] && [ ! -d $dir ]; then mkdir -p $dir; fi 

    command="openssl pkcs12 -in ${inpath} -out ${outpath} -passin pass:${inpwd} -passout pass: ${extraargs}"
    echo $command
    $command
    openssl rsa -in ${outpath} -out ${outpath} -passin pass:
}


#Usage - sh p12utils.sh topemwithpass files/badssl.com-client.p12 ./out/certandkeywithpass.pem badssl.com testpass -legacy
topemwithpass() {
	if [ -z ${1+x} ]; then echo "Please provide input p12 path. Usage topemwithpass <inp12path> <outpath> <inputpassword> <outpassword>"; exit 1; fi
	if [ -z ${2+x} ]; then echo "Please provide output cert path. Usage topemwithpass <inp12path> <outpath> <inputpassword> <outpassword>"; exit 1; fi
	if [ -z ${3+x} ]; then echo "Please provide input password. Usage topemwithpass <inp12path> <outpath> <inputpassword> <outpassword>"; exit 1; fi
	if [ -z ${4+x} ]; then echo "Please provide inpwd output password. Usage topemwithpass <inp12path> <outpath> <inputpassword> <outpassword>"; exit 1; fi


    inpath="$1"
    outpath="$2" 
    inpwd="$3"
    outpwd="$4"
    extraargs=$(echo "$@" | cut -d ' ' -f 5-)

    dir=$(dirname $2)
    if [ $dir != "." ] && [ ! -d $dir ]; then mkdir -p $dir; fi 

    command="openssl pkcs12 -in ${inpath} -out ${outpath} -passin pass:${inpwd} -passout pass:${outpwd} ${extraargs}"
    echo $command
    $command
}

#sh p12utils.sh getp12 out/cert-and-key.pem out/top12.p12 testpass testpass
getp12() {
	if [ -z ${1+x} ]; then echo "Please provide input p12 path. Usage getp12 <inpempath> <outp12path> <inputpassword> <outpassword>"; exit 1; fi
	if [ -z ${2+x} ]; then echo "Please provide output cert path. Usage getp12 <inpempath> <outp12path> <inputpassword> <outpassword>"; exit 1; fi
	if [ -z ${3+x} ]; then echo "Please provide input password. Usage getp12 <inpempath> <outp12path> <inputpassword> <outpassword>"; exit 1; fi
	if [ -z ${4+x} ]; then echo "Please provide output password. Usage getp12 <inpempath> <outp12path> <inputpassword> <outpassword>"; exit 1; fi


    inpath="$1"
    outpath="$2" 
    inpwd="$3"
    outpwd="$4"
    extraargs=$(echo "$@" | cut -d ' ' -f 5-)

    dir=$(dirname $2)
    if [ $dir != "." ] && [ ! -d $dir ]; then mkdir -p $dir; fi 

    command="openssl pkcs12 -export -in ${inpath} -out ${outpath} -passin pass:${inpwd} -passout pass:${outpwd} ${extraargs}"
    echo $command
    $command
}

"$@"