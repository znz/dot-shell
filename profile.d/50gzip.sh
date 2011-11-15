if [ -f /etc/debian_version ]; then
    export GZIP="-9 --rsyncable"
else
    export GZIP=-9
fi
