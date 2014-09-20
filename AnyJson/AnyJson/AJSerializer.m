//
//  AJTransformer.m
//  AnyJson
//
//  Created by casa on 14-9-19.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import "AJSerializer.h"
#import "AJPropertyDescriptor.h"

@implementation AJSerializer

#pragma mark - public method
+ (NSData *)jsonDataWithObject:(id<AJSerializable>)object
{
    return nil;
}

+ (NSString *)jsonStringWithObject:(id<AJSerializable>)object
{
    return nil;
}

+ (id)objectWithJsonString:(NSString *)jsonString
{
    return nil;
}

#pragma mark - private method
+ (id)serializeToBasicObject:(id)rawObject
{
    if (rawObject == NULL || rawObject == nil || [rawObject isKindOfClass:[NSNull class]]) {
        return [NSNull null];
    }
    
    id result = [NSNull null];
    
    
    
    return result;
}

@end
