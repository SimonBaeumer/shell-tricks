# Bash tricks

- [Fast switch](#fast-switch)
  * [git](#git)
  * [cd](#cd)
- [Get global ip](#get-global-ip)
  
## Fast switch

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

```bash
#!/usr/bin/env bash

function test () { echo "test"; }

function command() { echo "command" }

case $1 in
    test|command) $1 ;;
esac
```

Execute it:

```bash
$ ./simple-commands.sh test
called test function
```

## Loop

```bash
$ for i in {1..10}; do echo $i; done
```