# Bash tricks

- [Switch to previous directory](#switch-to-previous-directory)
  * [git](#git)
  * [cd](#cd)
- [Get global ip](#get-global-ip)
- [Simple commands](#simple-commands)
- [Loop](#loop)
- [Reuse arguments](#reuse-arguments)
- [Reuse commands](#reuse-commands)
- [Accept interactive commands](#accept-interactive-commands)
- [Last exit code](#last-exit-code)
  
## Switch to previous directory

Switch between the current and previous branch / directory. 

### git

```bash
$ git branch
* master
development

$ git checkout development
Switched to branch 'development'
$ git checkout - # Switch to previous
Switched to branch 'master'
$ git checkout -
Switched to branch 'development'
```

### cd

```bash
$ pwd
/
$ cd /tmp
$ cd - # Switch to previous
/
$ cd -
/tmp
```

## Get global ip

```bash
$ curl ifconfig.co # IPv4
50.110.14.21
$ curl -6 ifconfig.co # IPv6
2010:3f3f:113f:0:ea57:4497:7291:e422
```

## Simple commands

Create a script which calls functions by its` first argument. This is very useful to create simple scripts which could be a wrapper for other commands.

```bash
#!/usr/bin/env bash

function do_this () { echo "call do_this function"; }

function do_sth() { echo "call do_sth function" }

case "$1" in
    do_this|do_sth) "$1" ;;
esac
```

Execute it:

```bash
$ ./simple-commands.sh do_this
call do_this function
```

## Loop

Write simple one liner loops if you need to do some batch tasks.

```bash
$ for i in {1..10}; do echo "$i"; done
```

## Reuse arguments

```bash
$ ls /tmp
some_file.txt some_archive.tar.gz
$ cd !$
/tmp
```

## Reuse commands

```$bash
$ echo "reuse me"
reuse me
$ !!
echo "reuse me"
reuse me
```

## Accept interactive commands

```bash
$ yes | ./interactive-command.sh
Are you sure (y/n)
Accepted
yes: standard output: Broken pipe
```

The error message is printed because `yes` gets killed by `SIGPIPE` signal. This happens
if the pipe to `./interactive-command.sh` gets closed but `yes` still wants to write into it.

Ignore error message:

`$ yes 2>/dev/null | ./interactive-command.sh`

## Last exit code

```bash
$ ls /tmp
some_file.txt
$ echo $?
0
```