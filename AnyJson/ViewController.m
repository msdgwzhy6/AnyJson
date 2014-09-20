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
    
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([Playground class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        const char *propertyAttribute = property_getAttributes(propertyList[i]);
        NSString *propertyAttributeString = [NSString stringWithCString:propertyAttribute encoding:NSUTF8StringEncoding];
        NSLog(@"here i am");
    }
    
    // 2
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:nil];
    
    // 3
    NSDictionary *propertyMap = [AJClassHelper reflectProperties:[playground class]];
    NSLog(@"%@", propertyMap);
    
    
    
}

@end
