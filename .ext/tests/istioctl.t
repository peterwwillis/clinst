#!/usr/bin/env sh
[ "${DEBUG:-0}" = "1" ] && set -x
set -u

_t_vers_check () {
    # Test version check
    result="$(cliv -e "ext-ver-$ext_ver" $ext_name version --remote=false --short)"
    if [ $(expr "$result" : "$ext_ver") -eq 0 ] ; then
        return 1
    fi
}

ext_ver=1.10.2
ext_tests="ext_install versions vers_check"