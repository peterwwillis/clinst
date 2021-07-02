#!/usr/bin/env sh
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x

### Extension-specific variables
CLENV_E_NAME="${CLENV_E_NAME:-ansible}"
CLENV_E_REV="0.2.0"
CLENV_E_BIN_NAME="${CLENV_E_BIN_NAME:-$CLENV_E_NAME}"
CLENV_E_DLFILE="${CLENV_E_DLFILE:-$CLENV_E_NAME}"
CLENV_E_INSTDIR="${CLENV_E_INSTDIR:-$(pwd)}"
CLENV_E_BASEURL="https://pypi.org/pypi/$CLENV_E_NAME"
CLENV_E_BASEURL_ARGS=''
export CLENV_E_NAME CLENV_E_REV CLENV_E_BIN_NAME CLENV_E_DLFILE

### Extension-specific functions
PYTHON="" PYMOD=""
_detect_python () {
    [ -z "${PYTHON:-}" ] && command -v python3 >/dev/null && PYTHON="python3"
    [ -z "${PYTHON:-}" ] && command -v python  >/dev/null && PYTHON="python"
    [ -z "${PYTHON:-}" ] && echo "$0: Error: please install python" && exit 1
    if    $PYTHON -c 'import virtualenv' ; then PYMOD="virtualenv -p $PYTHON"
    elif  $PYTHON -c 'import venv'       ; then PYMOD="venv"
    else  echo "$0: Error: please install Python module virtualenv or venv"; exit 1; fi
}
_ext_versions () {  clenv -E "$CLENV_E_NAME" -X versions_pypi "$CLENV_E_BASEURL/json" | grep -e "^[0-9]\+\.[0-9]\+\.[0-9]\+$" ;  }
_ext_download () {
    _detect_python
    mkdir -p "$CLENV_E_INSTDIR"
    $PYTHON -m $PYMOD --clear "$CLENV_E_INSTDIR/usr/"
    "$CLENV_E_INSTDIR/usr/bin/pip" download pip "ansible==$CLENV_E_VERSION"
}
_ext_unpack () { return 0 ; }
_ext_install_local () {
    "$CLENV_E_INSTDIR/usr/bin/pip" install -U pip
    "$CLENV_E_INSTDIR/usr/bin/pip" install "ansible==$CLENV_E_VERSION"
    # Add the 'bin/ symlink so _ext_test works
    mkdir -p "$CLENV_E_INSTDIR/bin"
    if    [ -h "$CLENV_E_INSTDIR/usr/bin/$CLENV_E_BIN_NAME" -o -e "$CLENV_E_INSTDIR/usr/bin/$CLENV_E_BIN_NAME" ]
    then  ln -sf "$CLENV_E_INSTDIR/usr/bin/$CLENV_E_BIN_NAME" "$CLENV_E_INSTDIR/bin/$CLENV_E_BIN_NAME"
    fi
    # Add the '/usr/bin/' folder so we can use the python, pip, ansible-* files
    printf "pmunge \"$CLENV_E_INSTDIR/usr/bin\"\n" >> "$CLENV_E_INSTDIR/.env"
}

### The rest of this doesn't need to be modified
_ext_variables () { set | grep '^CLENV_E_' ; }
_ext_help () { printf "Usage: $0 CMD\n\nCommands:\n%s\n" "$(grep -e "^_ext_.* ()" "$0" | awk '{print $1}' | sed -e 's/_ext_//;s/^/  /g' | tr _ -)" ; }
if    [ $# -lt 1 ]
then  _ext_help ; exit 1
else  cmd="$1"; shift
      func="_ext_$(printf "%s\n" "$cmd" | tr - _)"
      [ -n "${CLENV_DIR:-}" -a -n "${CLENV_E_ENVIRON:-}" ] && [ -d "$CLENV_DIR/$CLENV_E_ENVIRON" ] && cd "$CLENV_DIR/$CLENV_E_ENVIRON"
      case "$cmd" in *) $func "$@" ;; esac
fi