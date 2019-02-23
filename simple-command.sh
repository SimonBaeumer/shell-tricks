#!/usr/bin/env bash

function do_this () { echo "call do_this function"; }

function do_sth() { echo "call do_sth function"; }

case "$1" in
    do_this|do_sth) "$1" ;;
    *) echo "Given argument does not exist"; exit 1;
esac
