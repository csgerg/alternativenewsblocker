#!/bin/bash
# I borrowed this script from here: 
# https://gist.github.com/vvasabi/a266fc4e37e372a1ad8c
# I using this to quickly 'validate' content of alive websites

dir="$(pwd)"
output="$dir/output"

if [ ! -d $dir/output ]; then
  mkdir "$dir/output"
fi

urls=`cat "$1"`

if [ -z "$*" ]; then 
  echo "Hey, feed the script with file! :)"
  echo "./capture-screenshot.sh bunchofurl.txt"
fi

i=1
for url in $urls; do
  # Convert url to file name
  path=`echo $url | sed -e 's/http:\/\/domain\.name\///g'`
  if [ -z $path ]; then
    path=home
  fi
  escaped=`echo $path | sed -e 's/:\/\//_/g'`
  printf -v filename "%03d-%s.png" $i "$escaped"

  # Begin capture
  echo "Generating $filename..."
  CutyCapt --url="$url" --out="$output/$filename" \
    --min-width=1280 --min-height=800 --insecure > /dev/null 2>&1
  i=$(($i + 1))
done

