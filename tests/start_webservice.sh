#!/usr/bin/env bash
port="11295"
host="0.0.0.0"
echo "Starting webservice (php $host:$port )"

$( cd "$( dirname "$0" )/pub" && /usr/bin/env php -S $host:$port/ &> /dev/null ) &

