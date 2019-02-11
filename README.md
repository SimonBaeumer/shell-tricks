# Bash tricks

- [Fast switch](#fast-switch)
  * [git](#git)
  * [cd](#cd)
  
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