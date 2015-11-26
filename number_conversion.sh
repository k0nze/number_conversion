#!/bin/bash

function syntax_msg {
    echo "DESCRIPTION:"
    echo "     This script returns for a given number the representation in the"
    echo "     hexadecimal, decimal, octal and binary system"
    echo ""
    echo "SYNTAX:"
    echo "     number_conversion.sh [{0x,0o,0b}]NUMBER"
    echo ""
    echo "OPTIONS:"
    echo "    -h, --help: displays this text"
    echo ""
    echo "NUMBER:"
    echo "    a number without prefix will be interpreted as decimal number."
    echo "    the following prefixes are used for interpreting the number in"
    echo "    different systems:"
    echo "    0x = hexadecimal"
    echo "    0o = octal"
    echo "    0b = binary"
}

if [ "${1}" == "-h" ] || [ "${1}" == "--help" ]; then 
    syntax_msg
    exit 0
fi

if [ -z "${1}" ]; then
    echo "no number was given"
    exit 1
fi

NUMBER=${1}
PREFIX=${NUMBER:0:2}

# hexdecimal input
if [ "${PREFIX}" == "0x" ]; then

    # extract suffix
    NUMBER=$(echo ${NUMBER} | cut -d'x' -f2)

    # upper case
    HEX=$(echo ${NUMBER} |tr '[a-z]' '[A-Z]')

    # conversion
    DEC=$(echo "ibase=16; ${HEX}" | bc)
    OCT=$(echo "obase=8; ${DEC}" |bc)
    BIN=$(echo "obase=2; ${DEC}" |bc)


# octal input
elif [ "${PREFIX}" == "0o" ]; then

    # extract suffix
    OCT=$(echo ${NUMBER} | cut -d'o' -f2)

    # conversion
    DEC=$(echo "ibase=8; ${OCT}" | bc)
    HEX=$(echo "obase=16; ${DEC}" |bc)
    BIN=$(echo "obase=2; ${DEC}" |bc)


# binary input
elif [ "${PREFIX}" == "0b" ]; then

    # extract suffix
    BIN=$(echo ${NUMBER} | cut -d'b' -f2)

    # conversion
    DEC=$(echo "ibase=2; ${BIN}" | bc)
    HEX=$(echo "obase=16; ${DEC}" |bc)
    OCT=$(echo "obase=8; ${DEC}" |bc)


# decimal input
else
    # conversion
    DEC=${NUMBER}
    HEX=$(echo "obase=16; ${NUMBER}" | bc)
    OCT=$(echo "obase=8; ${NUMBER}" |bc)
    BIN=$(echo "obase=2; ${NUMBER}" |bc)
fi

echo 0x${HEX}
echo 0o${OCT}
echo ${DEC}
echo 0b${BIN}
