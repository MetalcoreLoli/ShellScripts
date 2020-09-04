#!/bin/sh
declare link
declare threadName
declare filesFromThread

while [ -n "$1" ]; do
    case "$1" in 
        -l) 
            link=$2
            shift;;
    esac
    shift
done

threadName=`echo "$link" | grep -o "#[0-9]*" | sed 's/^.//'`
boardName=`echo $link | grep -o "/./res" | sed "s/\/res//"`
fileRegex="$boardName/src/$threadName\S*"
filesFromThread=$(curl $link | grep -o "$fileRegex" | sed 's/"//' | sed 's/>//' )

unique=$(echo "${filesFromThread[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')

printf "Begin\n"
for str in $unique; do
    fullFileName="https://2ch.hk$str"
    curl -s -O "$fullFileName" > /dev/null 
    time=`date | awk '{print $4}'`
    printf "[$fullFileName] was \033[38;2;0;156;50mdownloaded\033[39m at $time\n"
done
printf "End\n"
