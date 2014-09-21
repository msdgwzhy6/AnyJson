//
//  ViewController.m
//  AnyJson
//
//  Created by casa on 14-9-19.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import "ViewController.h"
#import "AnyJson.h"
#import "Playground.h"
#import "AJClassHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1
    Playground *playground = [[Playground alloc] init];
    OtherObject *otherObject = [[OtherObject alloc] init];
    otherObject.testInteger = 13;
    otherObject.isTest = YES;
    otherObject.name = @"casa";
    otherObject.testChar = 'c';
//    otherObject.charString = "here i am";
    playground.otherObject = otherObject;
    NSString *jsonString = [AJSerializer jsonStringWithObject:playground];
    NSLog(@"json string is %@", jsonString);
}

@end
