1.2 Git. Команды.
==

### Set up your local directory.

```
mkdir /path/to/your/project
cd /path/to/your/project
git init
git remote add origin git@bitbucket.org:arturigberdin/project-test.git
```

### Push existing project to repo.

```
cd /path/to/my/repo
git remote add origin git@bitbucket.org:arturigberdin/dating-test.git
git push -u origin --all # pushes up the repo and its refs for the first time
git push -u origin --tags # pushes up any tags
```


### Track. (Fetch origin/dev branch and switch to branch).

You need to create a local branch that tracks a remote branch. The following command will create a local branch named daves_branch, tracking the remote branch origin/daves_branch. When you push your changes the remote branch will be updated.

For earlier versions of git:
```
git checkout --track origin/daves_branch
```
For git 1.5.6.5 and higher:
```
git checkout --track -b origin/daves_branch
```

### Revert commit.

Можно отцепить последний коммит и перезаписать его новым, есть специальная последовательность команд

```
git reset --hard HEAD^
git push -f //форсом  счищает как раз с remote
```

Реверт коммита

```
git revert HEAD
```

`!!!Xcode может мержить удалением куска кода/файла, поэтому нужно внимательно изучать каждый коммит, который пушиться в репу.`

### Rename commit message

После можно посмотреть в гитлоге `git log`, что имя коммита поменялось.
```
git commit --amend -m "New commit message"
```

### Rebase.

