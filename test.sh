#!/bin/bash

function chkrun {
    erc=$1
    shift

    echo "TEST: $@"
    $@
    rc=$?
    echo -ne "RC=$rc\t"

    if [[ "$erc" = "$rc" ]]; then
	echo "OK"
    else
	echo "FAIL"
    fi
    echo
}

chkrun 0 ./check_lg-ripestat --asn=15372 --prefix=212.111.224.0/19 --peerings=3320,13237,20676
chkrun 0 ./check_lg-ripestat --asn=15372 --prefix=2a01:7700::/32 --peerings=3320,13237,20676

chkrun 2 ./check_lg-ripestat --asn=15372 --prefix=212.111.224.0/19 --peerings=3320,20676
chkrun 2 ./check_lg-ripestat --asn=15372 --prefix=2a01:7700::/32 --peerings=3320,20676

chkrun 2 ./check_lg-ripestat --asn=42 --prefix=212.111.224.0/19 --peerings=3320,20676
chkrun 2 ./check_lg-ripestat --asn=42 --prefix=2a01:7700::/32 --peerings=3320,20676

chkrun 1 ./check_lg-ripestat --asn=15372 --prefix=212.111.224.0/19 --peerings=3320,13237,20676 -w 500:,,
chkrun 2 ./check_lg-ripestat --asn=15372 --prefix=2a01:7700::/32 --peerings=3320,13237,20676 -c 500:
