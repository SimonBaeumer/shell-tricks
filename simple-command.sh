#!/usr/bin/env bash

function test () { echo "call test function"; }

function command() { echo "call command function" }

case $1 in
    test|command) $1 ;;
esac