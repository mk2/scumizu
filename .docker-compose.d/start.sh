#!/bin/sh

set -e

cmd="$@"

echo "!!! Waiting for mysql"
until mysql -h"db" -u"root" &> /dev/null
do
  sleep 1
done

>&2 echo "!!! MySQL is up - executing command"
