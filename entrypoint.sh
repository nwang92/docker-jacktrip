#!/bin/bash

set -e

whoami

jackd -d dummy --rate ${JACK_SAMPLE_RATE} --period ${JACK_PERIOD} & 
jack_wait -w -t 10

echo "hello"
jacktrip -S -t -z --bindport 4464 --nojackportsconnect --broadcast 1024 -q auto

echo "done running jacktrip"
tail -f /dev/null
