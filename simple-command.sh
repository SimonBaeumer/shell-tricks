#!/usr/bin/env bash

function test () { echo "test"; }

function command() { echo "command" }

case $1 in
    test|command) $1 ;;
esac