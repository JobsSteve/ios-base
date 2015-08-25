## 4. CocoaPods for using third party libraries.

## Описание.

`CocoaPods` библиотека управления зависимостями для OS X и iOS проектов.

`Недостатки`, которые решает CocoaPods:
* Следить за версиями библиотек и связями между собой.
* Общее места, где можно посмотреть все доступные библиотеки.
* Возможность обновлять исходный код библиотек. (отчасти решается спомощью `git submodules`).
* Возможность добавлять свой локальный код в библиотеку и обновлять до новой версии.

## Установка CocoaPods.

Check that CocoaPods installed. You see `/usr/bin/pod` or `pod not found`.
* ```$ which pod```

CocoaPods runs on Ruby, update RubyGems. 
* ```$ sudo gem update --system```

Install CocoaPods with RubyGems. 

* ```$ sudo gem install cocoapods```

Clones the CocoaPods Specs repository into ~/.cocoapods/ on your computer. 

* ```$ pod setup```

## Установка библиотек из Podfile-а.

This will create a default Podfile for your project.

* ```$ pod init```

Create Podfile for your project.

* ```$ vim Podfile```

Что бы закончить редактирование, нужно нажать <Esc> и ввести команду ```:wq``` (сохранить и выйти).

### Пример.

Add libs to Podfile:
```
platform:ios, '6.1'
pod 'SVProgressHUD', '~>0.8'
pod 'AFNetworking', '~>2.4'
pod 'MagicalRecord', '~>2.2'
```

Install dependencies to your project.
* ```$ pod install```

## Поиск библиотеки в Pod-aх.

```
$ pod search MagicalRecord
```

## Синтаксис.

```
//Указать точную версию:
pod 'SVProgressHUD', '0.9'

//Установка платформы:
platform :osx, ios '10.7'

//Добавить таргеты:
link_with 'MyApp', 'MyApp Tests'

//Версия 0.3.7 и выше до 0.4:
pod 'SWTableViewCell', '~> 0.3.7'

//Версия 0.1 и выше до 1.0:
pod 'DDPageControl', '~> 0.1'

//Убрать вaрнинги в подах VK-ios-sdk:
post_install do |installer_representation|
    installer_representation.project.targets.each do |target|
        if target.name == "Pods-VK-ios-sdk"
            target.build_configurations.each do |config|
                config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
            end
        end
    end
end

//Берем файлы из локальной папки проекта:
pod 'AFNetworking', :path => '~/Documents/AFNetworking'

//Используем ветку `master` в репозитории:
pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git'

//Используем другую ветку в репозитории, например `develop`:
pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :branch => 'dev'

//Используем тэг (`tag`) в репозитории:
pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :tag => '0.7.0'

//Использовать до коммита:
pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :commit => '082f8319af'

```
