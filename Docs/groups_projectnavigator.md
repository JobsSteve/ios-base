
## 1. Structure code by groups. (Groups structure in Project Navigator).

Организация кода по группам в Project Navigator-е и в директориях проекта.

![Groups structure in Project Navigator] (https://github.com/arthurigberdin/rg-ios-base/blob/master/Docs/project-navigator-structure.png)

* **App** имеет 8 подгрупп:
    * __Storyboards__: только storyboard файлы.
    * __Models__: все модельки включая классы Core Data и `xcdatamodeld` файл модели бд.
    * __Views__: все кастомные view, в том числе кастомны table view cells.
    * __Controllers__: все контроллеры.
    * __Managers__:  другие классы как контроллеры, но не view сontrollers, напрмиер класс http-клиент который управляет запросами к API.
    * __Categories__: все категории.
    * __Resources__: файлы ресурсы: картинки, шрифты, документы и тд.
    * __Supporting Files__: группа для шаблонных XCode файлов. (plist, main, pch).

