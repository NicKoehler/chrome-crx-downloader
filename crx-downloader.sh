#!/bin/sh

# checking if grep and curl are insalled
if ! command -v grep > /dev/null 2>&1
then
    echo "Install 'grep' and run again"
    exit

elif ! command -v curl > /dev/null 2>&1
then
    echo "Install 'curl' and run again"
    exit
fi

# assigning the user input to url
read -p "Insert the chrome extension link > " url

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
    echo "Invalid URL"
fi
