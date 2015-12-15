83. Upload Image. GUID (UUID).
==

## Upload Image

AFNetworking 2.0, 

```
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

Как узнать что отправляется на сервер при загрузке файла:

### Charles

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

## GUID. UUID.




