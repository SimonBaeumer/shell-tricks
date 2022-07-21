# Shell tricks

- [Switch to previous directory](#switch-to-previous-directory)
  * [git](#git)
  * [cd](#cd)
- [Get global ip](#get-global-ip)
- [Simple commands](#simple-commands)
- [Loop](#loop)
- [Loop with specified increment each iteration](#loop-with-specified-increment-each-iteration)
- [Sequences of letters or numbers](#sequences-of-letters-or-numbers)
- [Reuse arguments](#reuse-arguments)
- [Reuse commands](#reuse-commands)
- [Compare output of two commands](#compare-output-of-two-commands)
- [Fix last command](#fix-last-command)
- [Accept interactive commands](#accept-interactive-commands)
- [Last exit code](#last-exit-code)
- [Easy backup](#easy-backup)
- [Print to stderr](#print-to-stderr)
- [Debugging](#debugging)
- [Useful readline tricks](#useful-readline-tricks)
- [Repeat command](#repeat-command)
- [Substrings](#substrings)
- [Parallelism](#parallelism)
- [More resources](#more-resources)
  
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

# List disk usage by directories
$ for file in */ .*/ ; do du -sh $file; done
```

## Loop with specified increment each iteration

```bash
for i in {1..100..2}; do echo $i; done
1
3
5
7
...
```

## Sequences of letters or numbers

Brace expansion is great for lots of things.

``` bash
$ touch file{a..c}
$ ls
$ command ls
filea fileb filec
```

``` bash
$ touch file-{1..15}
$ ls
file-1	file-10	file-11	file-12	file-13	file-14	file-15	file-2	file-3	file-4	file-5	file-6	file-7	file-8	file-9
$ ls file-{9..12}
file-10	file-11	file-12	file-9
```

``` bash
$ printf "%s\n" file-{a..c}{1..3}
file-a1
file-a2
file-a3
file-b1
file-b2
file-b3
file-c1
file-c2
file-c3
```

(If you give `printf` more arguments than it expects, it automatically loops.)

## Reuse arguments

```bash
$ ls /tmp
some_file.txt some_archive.tar.gz
$ cd !$
/tmp
```

## Reuse commands

```bash
$ echo "reuse me"
reuse me
$ !!
echo "reuse me"
reuse me
```

## Compare output of two commands
```bash
diff <(echo "1 2 4") <(echo "1 2 3 4")
1c1
< 1 2 4
---
 > 1 2 3 4
```

## Fix last command

```bash
$ ehco foo bar bar
bash: ehco: command not found
$ ^ehco^echo   
foo bar baz 
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

## Easy backup

```bash
$ cp file.txt{,.bak}
$ ls -1
file.txt
file.txt.bak
```

## Print to stderr

```
$ >&2 echo hello
hello
```

## Debugging

Add `-xv` to your bash scripts, i.e.:

```
/usr/bin/env bash
set -xv
```

or `/bin/bash -xv script.sh`

## Useful `readline` tricks

If you use the standard `bash` `readline` bindings.

- `C-a` (aka `CTRL+A`) move cursor to beginning of line
- `C-e` (aka `CTRL+E`) move cursor to end of line
- `M-.` (aka `ALT+.`)  insert last argument of previous command (like `!$`, but you can edit it)

## Repeat command

Execute a command every two seconds and monitor its` output.
This is especially useful for waiting until a deployment or infrastructure provisioning is completed, i.e. on aws.

`watch -n2 echo hello`

## Parallelism

### Run everything at once

```
task(){
   sleep 0.5; echo "$1";
}

for thing in a b c d e f g; do 
  task "$thing" &
done
```

### Run N tasks in parallel

```
task(){
   sleep 0.5; echo "$1";
}

N=4
(
for thing in a b c d e f g; do 
   ((i=i%N)); ((i++==0)) && wait
   task "$thing" & 
done
)
```

## Substrings

```
$ a="apple orange"

$ echo ${a#* }
orange
$ echo ${a#*p}
ple orange
$ echo ${a##*p}
le orange

$ echo ${a% *}
apple
$ echo ${a%p*}
ap
$ echo ${a%%p*}
a
```
The # for finding first occurence from the start and % for the first occurence from the end. * for matching any pattern. For greedy matching ## and %%. 

## More resources

 - [BashFAQ](https://mywiki.wooledge.org/BashFAQ) - A full FAQ of useful stuff
