#!/bin/sh

# checks if a program is installed
command_exist() {
    if ! command -v $1 &> /dev/null
    then
        echo "Install '$1' and run again."
        exit
    fi
}
#use "&>" as in https://stackoverflow.com/a/677212/5623661

# checking if grep and curl exist
command_exist grep
command_exist curl

# assigning the user input to url
if [ -z $1 ]
then
    read -p "Insert the chrome extension link > " url
else
    url=$1
fi

# assigning filename and crx_id using grep and rexex
filename="$(echo $url| grep -oP '(?<=https:\/\/chrome\.google\.com\/webstore\/detail\/).+(?=\/)')"
crx_id="$(echo $url| grep -oP '(?<=https:\/\/chrome\.google\.com\/webstore\/detail\/'$filename'\/)[A-z-0-9]+')"

# if the variables exist download the file else echo "Invalid URL"
if !( [ -z $filename ] || [ -z $crx_id ] )
then
    echo "Downloading $filename.."
    file_url="https://clients2.google.com/service/update2/crx?response=redirect&prodversion=89.0.4356.6&acceptformat=crx2,crx3&x=id%3D"$crx_id"%26uc"
    curl -L -s -o "$filename.crx" "$file_url"
    echo "$filename downloaded."
else
    echo "Invalid URL."
fi
