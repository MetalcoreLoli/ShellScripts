#!/bin/sh
declare link
declare threadName
declare filesFromThread

while [ -n "$1" ]; do
    case "$1" in 
        -l) 
            link=$2
            shift;;
        -d)
            mkdir "$2" && cd "$2"
            printf "directory [\033[38;2;0;156;0m$2\033[39m] was created\n"
            shift;;
    esac
    shift
done

threadName=`echo "$link" | grep -o -E '([0-9]+.html)'| sed 's/\(\.html\)//g'`
boardName=`echo $link | grep -o "/./res" | sed "s/\/res//"`
fileRegex="$boardName/src/$threadName/\S*"
filesFromThread=$(curl $link | grep -o -E "$fileRegex" | sed 's/\("\|>\)//g'| sort -u)



begin=$(date | grep -o -E '([0-9]{2}:[0-9]{2}:[0-9]{2})+|([0-9]:[0-9]:[0-9])+')

printf "Begin at $begin\n"
for str in $filesFromThread; do
    fullFileName="https://2ch.hk$str"
    curl -s -O "$fullFileName" > /dev/null 
    time=$(date | grep -o -E '([0-9]{2}:[0-9]{2}:[0-9]{2})+|([0-9]:[0-9]:[0-9])+')
    printf "[$fullFileName] was \033[38;2;0;156;50mdownloaded\033[39m at $time\n"
done
end=$(date | grep -o -E '([0-9]{2}:[0-9]{2}:[0-9]{2})+|([0-9]:[0-9]:[0-9])+')
printf "End at $end\n"
