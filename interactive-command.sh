#!/usr/bin/env bash

RESULT=""

echo "Are you sure (y/n)"
read ${RESULT}

if [[ "${RESULT}" -ne "y" ]]; then
    echo "Aborted."
    exit 0
fi

echo "Accepted"