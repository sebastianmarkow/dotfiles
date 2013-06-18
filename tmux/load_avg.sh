#!/bin/sh

test $(uname) = 'Darwin' &&
sysctl -n vm.loadavg | awk '{print $2,$3,$4}'
test $(uname) = "Linux" &&
cut -d " " -f 1-3 /proc/loadavg;
