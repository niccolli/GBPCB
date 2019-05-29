#!/bin/bash

PROGNAME=$(basename $0)
VERSION="1.0"

usage() {
    echo "Usage: $PROGNAME OPTIONS FILE"
    echo "  This is cartridge read/write interface."
    echo "  For more detail, please refer to this page. https://niccol.li/cartridge/"
    echo ""
    echo "Options:"
    echo "  --write-rom   Write FILE to ROM area."
    echo "  --write-ram   Write FILE to RAM area."
    echo "  --write-mbc   Write FILE to MBC area."
    echo "  --read-ram    Read saved RAM data to FILE."
    echo ""
    exit 1
}

# 引数があるとき
# $OPT: 第1引数
# $2:   第2引数
for OPT in "$@"
do
    if [ -z $2]; then
        usage
        exit 1
    fi
    case "$OPT" in
        '--write-rom' )
            dfu-util -D $2 -d 0483:df11 -a 0 -s 0x08100000 -Z 0x100000
            exit 1
            ;;
        '--write-ram' )
            dfu-util -D $2 -d 0483:df11 -a 0 -s 0x080E0000 -Z 0x20000
            exit 1
            ;;
        '--write-mbc' )
            dfu-util -D $2 -d 0483:df11 -a 0 -s 0x08000000
            exit 1
            ;;
        '--read-ram' )
            dfu-util -U $2 -d 0483:df11 -a 0 -s 0x080E0000 -Z 0x20000
            exit 1
            ;;
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
