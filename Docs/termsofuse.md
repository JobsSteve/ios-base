62. Terms Of Use. Пользовательское соглашение.
==

##1. Пользовательское соглашение через WebView.

Пользовательское соглашение подгружается с сайта по url-ке в UIWebView и отображается пользователям.

```objc
    NSString *stringurl=[NSString stringWithFormat:@"http://stick-er.ru/terms"];
    
    NSURL *url=[NSURL URLWithString:stringurl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15.0];
    [self.webview loadRequest:theRequest];
```



