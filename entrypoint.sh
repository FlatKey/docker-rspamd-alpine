#!/bin/sh

# set standard logging if no modification exists
if [ ! -e /etc/rspamd/local.d/logging.inc ] && [ ! -e /etc/rspamd/override.d/logging.inc ];
then
    echo 'type = "console";' > /etc/rspamd/local.d/logging.inc
fi

rspamd -f -u rspamd -g rspamd &

pids=`jobs -p`

exitcode=0

terminate() {
    for pid in $pids; do
        if ! kill -0 $pid 2>/dev/null; then
            wait $pid
            exitcode=$?
        fi
    done
    kill $pids 2>/dev/null
}

trap terminate CHLD
wait

exit $exitcode
