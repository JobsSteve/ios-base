//
//  PPBackendManager.h
//  PartyPlace
//
//  Created by Arthur Bikmullin on 26.11.15.
//  Copyright © 2015 Ingenius Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPBackendManager : NSObject

//Singleton
+ (instancetype)sharedInstance;


//Login VK
- (void)requestVkontakteLogin:(NSDictionary *)params andBlock:(void (^)(NSDictionary *responseDict))successBlock;


//Methods
- (void)createParty;

- (void)uploadImage:(UIImage *)image;

- (void)loadPartyList;

@end
