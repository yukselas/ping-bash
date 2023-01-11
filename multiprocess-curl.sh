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
	 cmd="curl -s --location --request POST 'https://devk8s.isimplatform.io/isimcore/api/User' \
--header 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJMb2dpblRpbWUiOiIyMDIyLTEyLTEzVDE0OjMwOjMwLjcyNDI4NDErMDM6MDAiLCJFeHBpcmVUaW1lIjoiMjAyMy0wMy0xM1QxNDozMDozMC43MjQyODU4KzAzOjAwIiwiTGFzdFJlZnJlc2hlZFRpbWUiOiIyMDIyLTEyLTEzVDE0OjMwOjMwLjcyNDI4NzMrMDM6MDAiLCJQcmlvcml0eSI6MCwiUm9sZXMiOlsxLDIsMyw0LDUsNiw4LDksMTAsMTAwMSwxMDAyLDExMDEsMTEwMiwxMTAzLDExMDQsMTEwNV0sIlJvbGVzVXVpZCI6W10sIlVzZXJHcm91cHNJZHMiOltdLCJVc2VyR3JvdXBzTmFtZXMiOltdLCJSb2xHcm91cHNJZHMiOlsxXSwiRmlyc3RuYW1lIjoiaXNpbSIsIkxhc3RuYW1lIjoiaXNpbSIsIkxvZ2luVHlwZSI6MSwiU2Vzc2lvbklkIjoiNTViZjIzYzItMWI5ZS00MTY4LWI1ODgtZDgyMzE1NjZjMDk2IiwiVG9rZW4iOm51bGwsIlVzZXJJZCI6MSwiVXNlcm5hbWUiOiJpc2ltIiwiUGFzc3dvcmQiOm51bGwsIkNsaWVudCI6eyJJZCI6MSwiVXVpZCI6ImlzaW1fd2ViX2NsaWVudCIsIlBjTmFtZSI6IldlYkNsaWVudCJ9LCJGb3JjZUxvZ2luIjpmYWxzZX0.sILWpRCxu8OdPWvBH-A8aTb8GF1_c5XH-k2QMplc2sE' \
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
    "password": "!2345qawsedrfQ"'"
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


