14. Magical Record + MOGenerator.
==

__Ссылка на проект__
http://raptureinvenice.com/getting-started-with-mogenerator/


## MagicalRecord установка:

1. Добавляем MagicalRecord в Подфайл:

    ```
    vim Podfile

    platform :ios, 
    pod 'MagicalRecord'
    ```
    
2. Линкуем CoreData Framework в проект 
    `Project navigator > Targets > Build Phases > Link Binary With Libraries > + > CoreData.framework`
3. Импортируем в pch (pre-compiled header)
    ```objc
    #import "CoreData+MagicaRecord.h"
    ```
4. В Aппделегате при запуске (application:didFinishLaunchingWithOptions:)
    ```objc
    [MagicalRecord setupAutoMigrationCoreDataStack];
    ```
    ```objc
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        //MAGICAL RECORD
        [MagicalRecord setupCoreDataStackWithStoreNamed:@"Model.xcdatamodeld"];

        return YES;
    }
    - (void)applicationWillTerminate:(UIApplication *)application {
        [MagicalRecord cleanUp];
    }
    ```
5. Включаем логгер для MagicalRecord:
Этот дефайн можно найти в файле MagicalRecord.h

    ```objc
    #define MR_ENABLE_ACTIVE_RECORD_LOGGING 1 
    ```
6. Теперь можете кодить!


## MOGenerator установка

1. Скачайте и установите [MOGenerator](http://rentzsch.github.io/mogenerator/)

2. Добавьте __Aggregate__ таргет в проект и назовите его `Mogenerator`

3. Добавьте скрипт
    `Mogenerator > Build Phase > + > New Run Script Build Phase > оставляем поле Shell: /bin/sh`
    ObjC:
    ```
    mogenerator -m parking-ios/Models/Model.xcdatamodeld/Model.xcdatamodel -O parking-ios/Models/Model --template-var arc=true
    ```

4. Настройте сущностей
    `New file > Создаем новый файл Model.xcdatamodeld в директории Models > Создаем модели например: MMUser, MMSettings,     MMParkingCapture.`

    Когда модели созданы нужно настроить сущности модели `Populate class field Class > MMUser`. (Equal Name and Class)
   
    ![Equal Name and Class](https://github.com/arthurigberdin/rg-ios-base/blob/master/Images/Entity.png)
5. Ручной запуск скрипта

    Запуск скрипта __Mogenerator__ для обновления генерируемых файлов.
    Выбираем таргет Mogenerator и запускаем `hit ⌘B`. Запускается скрипт и генерируются файлы. Well done!


## Что такое MOGenerator

`MOGenerator` - генерирует `objc` код для кастомных классов-моделей CoreData. 
Mogenerator генерирует два класса `еntity-cущности` - один для **machines** и второй для **humans**. 
Машинный класс будет `перезаписываться` при запуске mogen скрипта.

Премущества MOGenerator:

> 1. Быстрое и легкая генерация конкретных классов для модели.
2. Представление в виде двух-классов.
3. Устраняет необходимость обертывать числовые аттрибуты в объект NSNumber.
4. Удобные setter-методы.
5. Удобные wrapper-методы для вставки и идентификации сущности.


### Как работает MOGen и пример использования

Теперь при обращении к данным у нас есть врапперы для NSNumber

```objc
if (user.isAdminValue) {
    ...
}
```

### Как работает Magical Record

Magical Record **Update** entity.
```objc
[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) 
{
        MMSettings *settings = [MMSettings MR_findFirst];
        if (settings == nil) {
            settings = [MMSettings MR_createEntityInContext:localContext];
        }
        settings.notifyIsEnabled = [NSNumber numberWithBool:_notificationSwitch.on];
        settings.notifySetTimer = _notificationTimerTextField.text;
        settings.userEmail = _notificationEmailTextField.text;
        
    } completion:^(BOOL contextDidSave, NSError *error) {
        MMSettings *settings = [MMSettings MR_findFirst];
        DLog(@"\n\nsettings = %@ %@ %@", settings.notifyIsEnabled, settings.notifySetTimer, settings.userEmail);
}];
```

**Добавление** новой Entity.
```objc
    MMSettings *settings = [MMSettings MR_findFirst];
    if (settings == nil) {
        settings = [MMSettings MR_createEntity];
    }
    settings.notifyIsEnabledValue = _notificationSwitch.on;
    settings.notifySetTimer = _notificationTimerTextField.text;
    settings.userEmail = _notificationEmailTextField.text;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
```

**Подтягиваем поля** у Entity для Presentation Layer.
```objc
    MMSettings *settings = [MMSettings MR_findFirst];
    self.notificationSwitch.on = settings.notifyIsEnabledValue;
    self.notificationTimerTextField.text = settings.notifySetTimer;
    self.notificationEmailTextField.text = settings.userEmail;
```


```objc
DBOrder *oldOrder = [DBOrder MR_findFirst];
         if (oldOrder){
             [oldOrder MR_deleteEntity];
         }
         
         //DBOrder
         DBOrder *order = [DBOrder MR_createEntity];
         
         order.b_ofertaId = @([[responseObject objectForKey:@"oferta_id"] integerValue]);
        
         NSDictionary *orderDict = [responseObject objectForKey:@"order"];
         order.b_orderId = @([[orderDict objectForKey:@"order_id"] integerValue]);
         
         NSArray *productArr = [orderDict objectForKey:@"products"];
         order.b_productId = @([[productArr[0] objectForKey:@"product_id"] integerValue]);
         order.b_cost = @([[productArr[0] objectForKey:@"cost"] integerValue]);
         order.b_price = @([[productArr[0] objectForKey:@"price"] integerValue]);
         order.b_total = @([[orderDict objectForKey:@"total"] integerValue]);
         order.b_count = @([productArr count]);
         
         //DBRequiredField
         NSArray *fields = [responseObject objectForKey:@"required_fields"];
         
         for (NSString *field in fields) {
             DBRequiredField *requiredField = [DBRequiredField MR_createEntity];
             requiredField.b_field = field;
             [order addRequiredFieldsObject:requiredField];
         }
         
         NSArray *fs = [DBRequiredField MR_findAll];
         NSLog(@"fs = %@", fs);
         
         [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
         
         for (DBRequiredField *rf in order.requiredFields) {
             NSLog(@"order = %@", rf.b_field);
         }
         
```

## Асинхронные запросы в базу


