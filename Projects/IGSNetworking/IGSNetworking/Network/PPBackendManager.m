//
//  PPBackendManager.m
//  PartyPlace
//
//  Created by Arthur Bikmullin on 26.11.15.
//  Copyright © 2015 Ingenius Systems. All rights reserved.
//

#import "PPBackendManager.h"

//Networking
#import <AFNetworking/AFNetworking.h>
#import "AFHTTPRequestOperationManager+AutoRetry.h"

//Constants
#import "PPNetworkConfig.h"


@interface PPBackendManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *authorizationToken;

@end

@implementation PPBackendManager

#pragma mark - Initialization

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
      shared = [[super alloc] initUniqueInstance];
    });

    return shared;
}

- (instancetype)initUniqueInstance
{
    self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    //    NSLog(@"current localization = %@", language);
    //    [self.manager.requestSerializer setValue:language forHTTPHeaderField:@"Accept-Language"];

    self.manager.securityPolicy.allowInvalidCertificates = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setBearerAuthorization:)
                                                 name:@"ChangeAccessToken"
                                               object:nil];

    [self setBearerAuthorization:nil];

    return [super init];
}

- (void)setBearerAuthorization:(NSNotification *)notification
{
    //Authorization Token
    NSString *at = @"QmpM-U_OOZrsEegkdcCMqwvl6lbKplhli-TVDHGqNXVE7aHWHjFNNonMejP00k74MguSxrMV3Ixm7RtXhKiyQ9ig-rK6LfNY5Htj1BqlxhIjdTRae1YSZlLp65gNjHjvKUSCngmoO9KaRNg_eH0xSl0AncHrM1G9CnAMOq5b9ltny8XDpBZsN4JTJ92PGihpxpAqXqUSuponGCRgS5Ft_3jFcHs1s6ZiGfhEZGQm7eX6XgGCZBkEKnOgFZWKAag40t4SbURv01_fLBNeijtK2RyKYOBOMKT0mxdYLs2AayPBDygeCSvsiLA8hOFgB1G8M9Q5BxsQLK9iXASB2jedXQ";

    if ([at length] > 5) {
        [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"%@ %@", @"bearer", at]
                              forHTTPHeaderField:@"Authorization"];
    }
    else {
        [self.manager.requestSerializer setValue:@"bearer" forHTTPHeaderField:@"Authorization"];
    }
}

#pragma mark - VK Account

- (void)requestVkontakteLogin:(NSDictionary *)params andBlock:(void (^)(NSDictionary *responseDict))successBlock
{
    [self postTemplateUrl:kVkontakteLogin paramsDict:params andBlock:successBlock];
}

#pragma mark - Template



- (AFHTTPRequestOperation *)requestUploadImage:(UIImage *)image andBlock:(void (^)(NSDictionary *responseDict))successBlock
{
    NSLog(@"HEADERS = %@", self.manager.requestSerializer.HTTPRequestHeaders);
    
    NSString *kBaseURLString = @"http://ppdev.igstest.ru/";
    NSString *kUploadImage = @"/api/File/Upload";
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[kBaseURLString stringByAppendingString:kUploadImage]]];
    
    //NSString *authorizationToken = [PPAuthorizationManager sharedInstance].accessToken.AccessToken;
    
    if ([self.authorizationToken length] > 5) {
        [request setValue:[NSString stringWithFormat:@"%@ %@", @"bearer", self.authorizationToken]
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
    
    NSLog(@"HEADERS = %@", request.allHTTPHeaderFields.debugDescription);
    
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request
                                                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                  NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                                                                  
                                                                                  if (successBlock)
                                                                                  {
                                                                                      successBlock(jsonDict);
                                                                                  }
                                                                                  else
                                                                                  {
                                                                                      
                                                                                      if (successBlock)
                                                                                      {
                                                                                          successBlock(nil);
                                                                                      }
                                                                                  }
                                                                              }
                                                                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                                  
                                                                                  NSLog(@"%@ Error: %@", [operation.request.URL lastPathComponent], error);
                                                                                  
                                                                                  if (successBlock)
                                                                                  {
                                                                                      successBlock(nil);
                                                                                  }
                                                                              }];
    
    [self.manager.operationQueue addOperation:operation];
    return operation;
}

- (AFHTTPRequestOperation *)postTemplateUrlWithMultipartData:(NSData *)data withUrl:(NSString *)url withName:(NSString *)dataName andBlock:(void (^)(NSDictionary *responseDict))successBlock
{
    NSLog(@"HEADERS = %@", self.manager.requestSerializer.HTTPRequestHeaders);

    AFHTTPRequestOperation *operation = [self.manager POST:url
        parameters:@{}
        constructingBodyWithBlock:^(id< AFMultipartFormData > _Nonnull formData) {
            
        NSString *fileName = [NSString stringWithFormat:@"%@.png",dataName];
            
          [formData appendPartWithFileData:data name:dataName fileName:fileName mimeType:@"image/png"];

        }
        success:^(AFHTTPRequestOperation *_Nonnull operation, id _Nonnull responseObject) {

          NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
          NSLog(@"RESPONSE: %@", jsonDict.debugDescription);
          if (!jsonDict)
          {
              jsonDict = @{};
          }
          if (successBlock)
              successBlock(jsonDict);
          else
          {
              if (successBlock)
                  successBlock(nil);
          }

        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
          //        NSError *error;
          //        NSData *objectData = [error.userInfo objectForKey:@"" dataUsingEncoding:NSUTF8StringEncoding];
          //        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&error];
          //
          NSString *newStr = [[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];

          NSLog(@"%@ ERROR: -- %@ --\n%@", newStr, [operation.request.URL lastPathComponent], error);
          if (successBlock)
              successBlock(nil);

        }];

    return operation;
}


- (AFHTTPRequestOperation *)postTemplateUrl:(NSString *)url paramsDict:(id)params andBlock:(void (^)(NSDictionary *responseDict))successBlock
{
    NSLog(@"HEADERS = %@", self.manager.requestSerializer.HTTPRequestHeaders);
    NSLog(@"PARAMS  = %@", params);
    
    AFHTTPRequestOperation *operation = [self.manager POST:url
        parameters:params
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
         NSLog(@"HEADERS = %@",  [[operation response] allHeaderFields]);
            
          NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
          NSLog(@"RESPONSE: %@", jsonDict.debugDescription);
          if (!jsonDict)
          {
              jsonDict = @{};
          }
          if (successBlock)
              successBlock(jsonDict);
          else
          {
              if (successBlock)
                  successBlock(nil);
          }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {

          NSString *newStr = [[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];

          NSLog(@"%@ Error: -- %@ --\n%@", newStr, [operation.request.URL lastPathComponent], error);

          if (successBlock)
              successBlock(nil);

          //          [TSMessage showNotificationWithTitle:NSLocalizedString(@"BCAFNetworknointernetconnectionerror", @"nointernetconnectionerror")
          //                                      subtitle:@""
          //                                          type:TSMessageNotificationTypeWarning];
          //show no internet connection error
          //          [NMNAlertViewManager showErrorAlertViewWithText:];

        }];

    //    NSLog(@"%@", operation.request);

    return operation;
}

- (void)loadPartyList
{
    [self getTemplateUrl:@"/api/Party/List?page=1&pageSize=10"
              paramsDict: @{}
                andBlock:^(NSDictionary *responseDict) {
                    
                    NSLog(@"responseDict = %@", responseDict);
                }];
}

- (AFHTTPRequestOperation *)getTemplateUrl:(NSString *)url paramsDict:(id)params andBlock:(void (^)(NSDictionary *responseDict))successBlock
{
    //NSLog(@"%@ request headers = %@", url, self.manager.requestSerializer.HTTPRequestHeaders);

    //NSLog(@"%@ with parameters = %@", url, params);
    AFHTTPRequestOperation *operation = [self.manager GET:url
        parameters:params
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];

          NSLog(@"responseObject: %@", jsonDict.debugDescription);
          if (!jsonDict)
          {
              jsonDict = @{};
          }

          if (successBlock)
              successBlock(jsonDict);
          else
          {
              if (successBlock)
                  successBlock(nil);
          }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {

          NSString *newStr = [[NSString alloc] initWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];

          NSLog(@"%@ Error: -- %@ --\n%@", newStr, [operation.request.URL lastPathComponent], error);

          if (successBlock)
              successBlock(nil);

          //          [TSMessage showNotificationWithTitle:NSLocalizedString(@"BCAFNetworknointernetconnectionerror", @"nointernetconnectionerror")
          //                                      subtitle:@""
          //                                          type:TSMessageNotificationTypeWarning];
        }];

    return operation;
}

#pragma mark - Actions

- (void)createParty {
    
    //NSMutableDictionary *params = [@{@"name": name, @"mode":isPrivate?@"private":@"public"} mutableCopy];
    
    NSDictionary *params = @{ 
                              @"CoverFileId": @"00000000-0000-0000-0000-000000000000",
                              @"StartDate": @"2016-12-09T11:08:44.820Z",
                              @"EndDate": @"2016-12-09T11:08:44.820Z",
                              @"Name": @"string",
                              @"Conditions": @"string",
                              @"Cost": @0
                              };
    
    [[PPBackendManager sharedInstance] postTemplateUrl:@"/api/Party/Create"
                                            paramsDict:params
                                              andBlock:^(NSDictionary *responseDict) {
                                                  
                                                  //NSLog(@"responseDict = %@", responseDict);
                                                  
                                              }];
}

- (void)uploadImage:(UIImage *)image {
    
    //NSData *imageData = UIImagePNGRepresentation(image);
    
     /*
     [[PPBackendManager sharedInstance] postTemplateUrlWithMultipartData:imageData
     withUrl:@"/api/File/Upload"
     withName:@"file"
     andBlock:^(NSDictionary *responseDict) {
     
     NSLog(@"responseDict = %@", responseDict);
     }];
     */
    
    [[PPBackendManager sharedInstance] requestUploadImage:image andBlock:^(NSDictionary *responseDict) {
        
        NSLog(@"responseDict = %@", responseDict);
    }];
}

@end
