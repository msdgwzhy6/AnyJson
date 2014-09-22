//
//  AJTransformer.m
//  AnyJson
//
//  Created by casa on 14-9-19.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import "AJSerializer.h"
#import "AJObject2JsonSerializer.h"
#import "AJJson2ObjectSerializer.h"

@implementation AJSerializer

#pragma mark - public method
+ (NSData *)jsonDataWithObject:(id)object
{
    id basicObject = [AJObject2JsonSerializer serializeToBasicObject:object];
    return [NSJSONSerialization dataWithJSONObject:basicObject options:0 error:nil];
}

+ (NSString *)jsonStringWithObject:(id)object
{
    NSString *jsonString = [[NSString alloc] initWithData:[AJSerializer jsonDataWithObject:object] encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (id)objectWithJsonData:(NSData *)jsonData targetObjectClass:(Class)targetObjectClass
{
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    return [AJJson2ObjectSerializer transformJsonObject:jsonObject toTargetObjectClass:targetObjectClass];
}

+ (id)objectWithJsonString:(NSString *)jsonString targetObjectClass:(Class)targetObjectClass
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [AJSerializer objectWithJsonData:jsonData targetObjectClass:targetObjectClass];
}

@end
