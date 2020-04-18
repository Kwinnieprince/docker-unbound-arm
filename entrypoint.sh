#!/bin/bash

DO_IPV6=${DO_IPV6:-yes}
DO_IPV4=${DO_IPV4:-yes}
DO_UDP=${DO_UDP:-yes}
DO_TCP=${DO_TCP:-yes}
VERBOSITY=${VERBOSITY:-0}
NUM_THREADS=${NUM_THREADS:-1}
EDNS_BUFFER_SIZE=${EDNS_BUFFER_SIZE:-1472}
CACHE_MIN_TTL=${CACHE_MIN_TTL:-3600}
CACHE_MAX_TTL=${CACHE_MAX_TTL:-86400}
HIDE_IDENTITY=${HIDE_IDENTITY:-yes}
HIDE_VERSION=${HIDE_VERSION:-yes}
INTERFACE=${INTERFACE:-0.0.0.0}
PORT=${PORT:-5333}
HARDEN_GLUE=${HARDEN_GLUE:-yes}


sed 's/{{DO_IPV6}}/'"${DO_IPV6}"'/' -i /etc/unbound/unbound.conf
sed 's/{{DO_IPV4}}/'"${DO_IPV4}"'/' -i /etc/unbound/unbound.conf
sed 's/{{DO_UDP}}/'"${DO_UDP}"'/' -i /etc/unbound/unbound.conf
sed 's/{{DO_TCP}}/'"${DO_TCP}"'/' -i /etc/unbound/unbound.conf
sed 's/{{VERBOSITY}}/'"${VERBOSITY}"'/' -i /etc/unbound/unbound.conf
sed 's/{{NUM_THREADS}}/'"${NUM_THREADS}"'/' -i /etc/unbound/unbound.conf
sed 's/{{EDNS_BUFFER_SIZE}}/'"${EDNS_BUFFER_SIZE}"'/' -i /etc/unbound/unbound.conf
sed 's/{{CACHE_MIN_TTL}}/'"${CACHE_MIN_TTL}"'/' -i /etc/unbound/unbound.conf
sed 's/{{CACHE_MAX_TTL}}/'"${CACHE_MAX_TTL}"'/' -i /etc/unbound/unbound.conf
sed 's/{{HIDE_IDENTITY}}/'"${HIDE_IDENTITY}"'/' -i /etc/unbound/unbound.conf
sed 's/{{HIDE_VERSION}}/'"${HIDE_VERSION}"'/' -i /etc/unbound/unbound.conf
sed 's/{{INTERFACE}}/'"${INTERFACE}"'/' -i /etc/unbound/unbound.conf
sed 's/{{PORT}}/'"${PORT}"'/' -i /etc/unbound/unbound.conf
sed 's/{{HARDEN_GLUE}}/'"${HARDEN_GLUE}"'/' -i /etc/unbound/unbound.conf


exec unbound -c /etc/unbound/unbound.conf -d -v
