#!/usr/bin/env sh
[ "${DEBUG:-0}" = "1" ] && set -x
set -u

_t_1 () {
    # Test extension install
    if ! clenv -f -E "$ext_name=$ext_ver" -e "ext-ver-$ext_ver" ; then
        return 1
    fi
}
_t_2 () {
    # Test version check
    result="$(clenv -e "ext-ver-$ext_ver" $ext_name --version | head -1)"
    if [ ! "$result" = "Terraform v0.12.31" ] ; then
        return 1
    fi
}

ext_ver=0.12.31
ext_tests="1 2"
