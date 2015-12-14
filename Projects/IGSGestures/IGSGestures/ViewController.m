//
//  ViewController.m
//  IGSGestures
//
//  Created by Artur on 14/12/15.
//  Copyright © 2015 Artur Igberdin. All rights reserved.
//

#import "ViewController.h"

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


- (IBAction)yellowViewTapGesture:(id)sender {
    
    NSLog(@"Yellow View Tap Gesture");
}

- (IBAction)simpleButtonGesture:(id)sender {
    
    NSLog(@"Simple Button Tap Gesture");
}

- (IBAction)simpleLabelTapGesture:(id)sender {
    
    NSLog(@"Simple Label Tap Gesture");
}
- (IBAction)trollFaceImageViewTapGesture:(id)sender {
    
    NSLog(@"Troll Face ImageView Tap Gesture");
}

@end
