#!/bin/bash


# ornek kullanim: ./multiprocess-curl.sh 3 3 aysex

export numberofp=$1
export maxp=$2
#export username=$3
export logdir=allocate
mkdir -p $logdir 2>/dev/null # 2>/dev/null ifedesi eger dizin mevcutsa dahi ekranda gozukecek hata mesajini yutar
if [[ -e "./$logdir/" ]]; then
    rm -fr $logdir/*
fi


multicurlprocess () {
	 cmd="curl -s --location -X  POST 'https://devk8s.isimplatform.io/cerberus/api/license/allocate' \
--header 'Content-Type: application/json' -d '{"'"'"user"'"'":1,"'"'"asset"'"'":0}' -o $logdir/$1.output"
 #echo $cmd
    echo $cmd > $logdir/$1.cmd 
    eval $cmd  # eval komutu kendinden sonraki string komutu execute eder
}

for i in $(seq 1 ${numberofp}); do 

    multicurlprocess $i &
    if [[ "$(expr $i % $maxp)" == "0" ]]; then    #$() subshell acar
        wait
    fi
done