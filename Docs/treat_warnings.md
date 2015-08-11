Warnings in Project
==

Продукт должен разрабатываться без warning-ов.

1. Нужно устранять все warning-и в сторибордах и констрэинтах. 

2. В Подах нужно игнорить все warning-и из сторонних библиотек.

3. Убираем warning-и связанные с устаревшим кодом в самом проекте.

4. Убираем код или комментим код который не используется чтобы избегать warning-ов. 


## 10. Treat "Warnings" as errors. (Hide warnings in XCode).

**Treat warnings as errors.**

![Treat warnings as errors](https://github.com/arthurigberdin/rg-ios-base/blob/master/Images/treat_warnings_as_errors.png)


**Hide warnings in XCode.**

Select Project in left navigator and select target go to build phase and Put -w in Build Phase of target file. It will hide all compiler warnings 

`Compiler flag: -w`

![Hide warnings](https://github.com/arthurigberdin/rg-ios-base/blob/master/Images/hide_warnings.png)

##Disable Storyboard warnings

I needed to completely restart XCOde for the `interface Builder XIB Compiler - Options` `WARNINGS Flag = NO` the storyboard warnings to be considered!


