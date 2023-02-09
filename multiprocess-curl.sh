#!/bin/bash


# ornek kullanim: ./multiprocess-curl.sh 3 3 aysex

export numberofp=$1
export maxp=$2
export username=$3
export logdir=output
mkdir -p $logdir 2>/dev/null # 2>/dev/null ifedesi eger dizin mevcutsa dahi ekranda gozukecek hata mesajini yutar
if [[ -e "./$logdir/" ]]; then
    rm -fr $logdir/*
fi


multicurlprocess () {
	 cmd="curl -s --location --request POST 'abc/api/User' \
--header 'Authorization: .--' \
--header 'Content-Type: application/json' \
--data-raw '{"'
    "priority": 0,
    "isActive": false,
    "encryptedPassword": false,
    "username": "'"${username}$1"'",
    "firstname": "yuksl",
    "lastname": "ghgh",
    "emailAddress": null,
    "phoneNumber": null,
    "password": "!234"'"
}' -o $logdir/$1.output"
    echo $cmd > $logdir/$1.cmd 
    eval $cmd  # eval komutu kendinden sonraki string komutu execute eder


}

for i in $(seq 1 ${numberofp}); do 

    multicurlprocess $i &
    if [[ "$(expr $i % $maxp)" == "0" ]]; then    #$() subshell acar
        wait
    fi
done


