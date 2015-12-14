//
//  ViewController.m
//  IGSNetworking
//
//  Created by Artur on 14/12/15.
//  Copyright © 2015 Artur Igberdin. All rights reserved.
//

#import "ViewController.h"

//API
#import "PPBackendManager.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Events

- (IBAction)createEventTapped:(id)sender {
    
    [[PPBackendManager sharedInstance] createParty];
}

- (IBAction)eventListTapped:(id)sender {
    
    [[PPBackendManager sharedInstance] loadPartyList];
}

#pragma mark - Actions

- (void)createEvent {
    
}

- (void)eventList {
    
}



@end
