
## 9. Graphic Assets.

[Используем Asset Catalogs (Images.xcassets) в Xcode.](https://developer.apple.com/library/ios/recipes/xcode_help-image_catalog-1.0/Recipe.html)

1. Должны включать файлы @2x и @3x размеров.
 
 * Для создания и нарезки графики рекомендуется использовать Sketch).
 * Если нет размеров @3x то на новых экранах iPhone6/6+ будет заметна нечеткая графика).

2. Используем JPEG формат для больших картинок и в том числе для background-ов. 

 * JPEG весит меньше чем PNG иногда в разы.

3. Правильно именуем графические файлы. Создаем читаемые файлы. 

 * Примеры: Button Back Lobby, Button Create Table, Button Start Game.
 * Примеры др. стиля: SplashLogo, FemaleIcon, MaleIcon, TourBackground, TourBitmap.

![Правильно именуем графические файлы.](https://github.com/arthurigberdin/rg-ios-base/blob/master/Images/naming_image_assets.png)
