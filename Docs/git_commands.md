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





