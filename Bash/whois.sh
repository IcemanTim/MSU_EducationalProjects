#!/usr/bin/env bash

# создание нужной директории
rm -rf "$1"
mkdir "$1"

# создание необходимого имени файла для сохранения
if [ "$2" == "domain" ]; then
	domain_name=`basename $3`

	ch_name=${domain_name#*/} # удаление префикса http*://
	ch_name=${ch_name#*w.} # удаление префикса www.
	name=${ch_name//./_} # случай многоуровневого домена 

	file_name="${name}.html"

	service_name="https://www.whois.com/whois/"
	request="${service_name}${ch_name}"
	curl "$request" >> "./$1/${file_name}"
elif [[ "$2" == "file" ]]; then
	FILE="$3"
	while read LINE; do
		domain_name=`basename $LINE`
    	ch_name=${domain_name#*/} # удаление префикса http*://
		ch_name=${ch_name#*www.} # удаление префикса www.
		name=${ch_name//./_} # случай многоуровневого домена 
		file_name="${name}.html"
		service_name="https://www.whois.com/whois/"
		request="${service_name}${ch_name}"
		curl "$request" >> "./$1/${file_name}"
	done < $FILE	
fi
