2. Structure code by groups. (Groups structure in Project Navigator).
==

## Project Navigator
Организация кода по группам в __Project Navigator__ и в __директориях проекта__.

![Groups structure in Project Navigator] (https://github.com/arthurigberdin/rg-ios-base/blob/master/Images/project_navigator_groups.png)

* **App** имеет 10 подгрупп:
    * __Storyboards__: только `сториборды` и `LaunchScreen.xib` 
    
    * __Models__: все модели включая `классы CoreData` и `xcdatamodeld файл` модели бд.
    
    * __Views__: все кастомные `view компоненты`, в том числе `кастомные table view cells`.
    
    * __Controllers__: все `view controllers` классы.
    
    * __Services__:  все `классы сервисы` (это классы как контроллеры, но не view сontrollers, напрмиер класс http-клиент который управляет запросами к API).
    
    * __Categories__: все `категории`(расширения классов).
    
    * __Tools__: свои `классы-хелперы`, `классы-обертки` c выделенным функционалом для сторонних библиотек
    
    * __Resources__: файлы ресурсы: `Images.xassets`, `Fonts`, `Localizable.strings`, `Sounds` и тд.
    
    * __Supporting Files__: группа для `шаблонных Xcode-файлов`. (plist, main, pch).
    
    * __Static Libs__: `статические библиотеки`, которые не вошли в Pod-ы, либо `симлинки на библиотеки` в Pod-ах.

###Директории внутри Project Navigator

Только директории `которые создаются внутри Project Navigator`, можно сортировать, переименовывать.

## Warning c `Info.plist`.

1. Target > Build Phases > Copy Buncle Resources

2. Нужно удалить из списка `Info.plist`.


