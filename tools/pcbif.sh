#!/bin/bash

PROGNAME=$(basename $0)
VERSION="1.0"

usage() {
    echo "Usage: $PROGNAME [OPTIONS] FILE"
    echo "  This is cartridge read/write interface."
    echo "  For more detail, please refer to this page. https://niccol.li/cartridge/"
    echo ""
    echo "Options:"
    echo "  --write-rom   "
    echo "  --write-ram   "
    echo "  --write-mbc   "
    echo "  --read-ram    "
    echo ""
    exit 1
}

# 引数があるとき
# $OPT: 第1引数
# $2:   第2引数
for OPT in "$@"
do
    case "$OPT" in
        *)
            usage
            exit 1
            ;;
    esac
done

# 引数がないとき
if [ -z $param]; then
    usage
    exit 1
fi
