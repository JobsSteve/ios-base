83. Upload Image. GUID (UUID).
==

## Upload Image

AFNetworking 2.0

```objc
- (void)uploadPhoto:(UIImage *)photo {

AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://ppdev.igstest.ru"]];

AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];

NSString *at = [PPAuthorizationManager sharedInstance].accessToken.AccessToken;
if ([at length] > 5) {
[requestSerializer setValue:[NSString stringWithFormat:@"%@ %@", @"bearer", at] forHTTPHeaderField:@"Authorization"];
}
else {
[requestSerializer setValue:@"bearer" forHTTPHeaderField:@"Authorization"];
}
//[requestSerializer setAuthorizationHeaderFieldWithUsername:user password:pass];

manager.requestSerializer = requestSerializer;

NSData *imageData = UIImageJPEGRepresentation(photo, 0.5);

NSDictionary *parameters = @{};
//NSDictionary *parameters = @{@"username": self.username, @"password" : self.password};

AFHTTPRequestOperation *op = [manager POST:@"/api/File/Upload" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

//do not put image inside parameters dictionary as I did, but append it!
[formData appendPartWithFileData:imageData name:@"attachment[file]" fileName:@"picture.png" mimeType:@"image/png"];

} success:^(AFHTTPRequestOperation *operation, id responseObject) {

NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);

} failure:^(AFHTTPRequestOperation *operation, NSError *error) {

NSLog(@"Error: %@ ***** %@", operation.responseString, error);
}];

NSLog(@"BODY = %@", [op responseString]);

[op start];

}
```

__Как узнать что отправляется на сервер при загрузке файла?__

Можно использовать `Charles Web Debugging Proxy`

### Структура запроса.

__Headers__

```
POST /api/File/Upload HTTP/1.1
Host	ppdev.igstest.ru
Content-Type	multipart/form-data; boundary=Boundary+9BB1760B1642C772
Accept-Encoding	gzip, deflate
Connection	keep-alive
Accept	*/*
User-Agent	PartyPlace/0.1 (iPhone; iOS 9.1; Scale/2.00)
Accept-Language	en-US;q=1
Authorization	bearer HNYkYZ1bEdoH4DY4oWEYu_kdCrOxB6EXY9cLGH02BzLZFsGFTegw9pKPNUiI5374vD-ajyAWgFQcHsee7sXz3nUu2OHrpoTW-np3Jg1XpivMKeQoRWviFLvp8YCu9loguiz2Kju29WuSRnpJSuc3SZMDJl8ghKY_GOWEzp2Q1HHRhaAhzwrlMNeHVH7FNPuQE4iqBbexi6DDI4YcN975Ify5F79Jz8LusRpDd9ZWoU2j_nsXGhtIGUysCWmFvaqdV7aCKbF3AHuq-waYQ0CYsD1kZXRiuqWjsCpiBGh6KalQolTbxs-1uHsOayQfE7Ip
Content-Length	6816
```

__Authentication__

```
Bearer Authentication	
Data	HNYkYZ1bEdoH4DY4oWEYu_kdCrOxB6EXY9cLGH02BzLZFsGFTegw9pKPNUiI5374vD-ajyAWgFQcHsee7sXz3nUu2OHrpoTW-np3Jg1XpivMKeQoRWviFLvp8YCu9loguiz2Kju29WuSRnpJSuc3SZMDJl8ghKY_GOWEzp2Q1HHRhaAhzwrlMNeHVH7FNPuQE4iqBbexi6DDI4YcN975Ify5F79Jz8LusRpDd9ZWoU2j_nsXGhtIGUysCWmFvaqdV7aCKbF3AHuq-waYQ0CYsD1kZXRiuqWjsCpiBGh6KalQolTbxs-1uHsOayQfE7Ip
```

__Multipart__

```
attachment[file]	picture.png
```

__Body__

```
--Boundary+9BB1760B1642C772
Content-Disposition: form-data; name="attachment[file]"; filename="picture.png"
Content-Type: image/png
```

__Response__

От сервера получаем GUID для сохранения файла (картинки)

```
{"success":true,"result":"a0d5b66e-eee4-4b15-8b71-803ecd12be08"}
```

### Альтернативный вариант точно такого же запроса.
```
- (AFHTTPRequestOperation *)requestUploadImage:(UIImage *)image andBlock:(void (^)(NSDictionary *responseDict))successBlock
{
    //NSLog(@"HEADERS = %@", self.manager.requestSerializer.HTTPRequestHeaders);
    
    NSString *kBaseURLString = @"http://ppdev.igstest.ru";
    NSString *kUploadImage = @"/api/File/Upload";
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[kBaseURLString stringByAppendingString:kUploadImage]]];
    
    NSString *authorizationToken = [PPAuthorizationManager sharedInstance].accessToken.AccessToken;
    
    
    if ([authorizationToken length] > 5) {
        [request setValue:[NSString stringWithFormat:@"%@ %@", @"bearer", authorizationToken]
         forHTTPHeaderField:@"Authorization"];
    }
    else {
        [request setValue:@"bearer" forHTTPHeaderField:@"Authorization"];
    }
    
    request.HTTPMethod = @"POST";
    
    NSString *boundary = @"----WebKitFormBoundarycC4YiaUFwM44F6rT";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"attachment[file]\";filename=\"picture.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:imageData]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSString *strData = [[NSString alloc]initWithData:body encoding:NSUTF8StringEncoding];
    NSLog(@"BODY = %@",strData);
    
    NSLog(@"REQUEST HEADERS = %@", request.allHTTPHeaderFields.debugDescription);
    NSLog(@"REQUEST HEADERS = %@", request.allHTTPHeaderFields);
    
    AFHTTPRequestOperation *operation =
    [self.manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:nil];
                                                                                  
        if (successBlock) {
            successBlock(jsonDict);
        }
        else {
            if (successBlock) {
                  successBlock(nil);
            }
        }
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@ Error: %@", [operation.request.URL lastPathComponent], error);
          if (successBlock) {
              successBlock(nil);
          }
    }];
    
    [self.manager.operationQueue addOperation:operation];
    return operation;
}
```

## GUID. UUID.




