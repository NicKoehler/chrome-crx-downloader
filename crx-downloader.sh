#!/bin/sh

# checks if a program is installed
command_exist() {
    if ! command -v $1 > /dev/null 2>&1
    then
        echo "Install '$1' and run again."
        exit
    fi
}

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

# if the variables exists download the file else echo "Invalid URL"
if !( [ -z $filename ] || [ -z $crx_id ] )
then
    echo "Downloading $filename.."
    file_url="https://clients2.google.com/service/update2/crx?response=redirect&os=win&arch=x86-64&os_arch=x86-64&nacl_arch=x86-64&prod=chromecrx&prodchannel=unknown&prodversion=83.0.4103.61&acceptformat=crx2,crx3&x=id%3D"$crx_id"%26uc"
    curl -L -s -o "$filename"".crx" "$file_url"
    echo "$filename scaricato."
else
    echo "Invalid URL."
fi
