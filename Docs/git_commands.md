1. Git. Git Commands. Git Flow. gitignore. Командная разработка.
==

## Git Commands

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

```
git rebase
```

##Git Flow. Командная разработка.

### Коммит

1 мысль = 1 коммиту.

Коммитим часто, атомарно, маленькими частями.

Легче пуллится - если командная разработка.

Позволяет менеджеру следить за работой разработчиков.

master ветка

### Milestone

и на будущее - слияние лучше делать пуллреквестом на гитхабе, у этого есть как минимум 2 приятных последствия

Сергей Галездинов [5:58 PM] 1. ты обозначаешь milestone, номер билда, ушедший на золото

Сергей Галездинов [5:59 PM] 2. ты отделяешь пачку коммитов визуально, обозначая тот же milestone, плюс ты всегда потом можешь посмотреть даты и конкретных контрибуторов, создававших пуллреквесты

Сергей Галездинов [6:00 PM] мерж веток тоже ок, но теряется граница слияний, что плохо в организационном плане

## Ignoring Files - gitignore.

Git использует специальный файл `.gitignore`, который хранит информацию о файлах которые вы не желаете коммитить в `Git репозиторий`. Эти файлы игнорятся когда выполняется Git коммит.

Для создания файла используем команду - 
`$ touch .gitignore`

Содержания файла .gitignore для Xcode:
* settting file (файлы настроек) `.DS_Store`
* private scheme file (файлы схем) `.xcuserdatad`
* some temporary files by vim (временные файлы) `.swp files`
* some secret files (конфиденциальные файлы) `tokens, secrets`
* pod files (подфайлы все таки лучше хранить в репозитории)`.pods`
* user data in xcworkspace. (пользовательские данные из проекта)
`project.xcworkspace/`
`xcuserdata/`

```
# Xcode
#
build/
*.pbxuser
!default.pbxuser
*.mode1v3
!default.mode1v3
*.mode2v3
!default.mode2v3
*.perspectivev3
!default.perspectivev3
xcuserdata
*.xccheckout
*.moved-aside
DerivedData
*.hmap
*.ipa
*.xcuserstate

# OS X temporary files
#
.DS_Store
.Trashes
.swp

# CocoaPods
#
# We recommend against adding the Pods directory to your .gitignore. However
# you should judge for yourself, the pros and cons are mentioned at:
# http://guides.cocoapods.org/using/using-cocoapods.html#should-i-ignore-the-pods-directory-in-source-control
#
# Pods/
```

Чтобы `файл игнорился` 
* Проверить что файл игнорится, можно командой `$ git status`
* Нужно чтобы он `был удален с удаленного репозитория`.
* Допустим чтобы игнорился UserInterfaceState.xcuserstate внутри xcodeproj залитого на GitHub, нужно зайти в GitHub и удалить этот файл.

С помощью `.gitignore` можно осуществить игнорирование ненужных или конфиденциальных файлов в новом проект.

Чтобы удалить файлы которые не должны быть в файле проекта `ProjectName.xcodeproj или ProjectName.xcworkspace` можно использовать `редактор Sublime`.





