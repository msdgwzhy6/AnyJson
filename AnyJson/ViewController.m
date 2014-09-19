//
//  ViewController.m
//  AnyJson
//
//  Created by casa on 14-9-19.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import "ViewController.h"
#import "AnyJson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *jsonString = @"{'casa':{'cary':1, 'yuki':2}}";
    NSLog(@"%@", [AJSerializer objectWithJsonString:jsonString]);
}

@end
