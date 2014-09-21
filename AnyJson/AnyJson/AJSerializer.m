//
//  AJTransformer.m
//  AnyJson
//
//  Created by casa on 14-9-19.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import "AJSerializer.h"
#import "AJPropertyDescriptor.h"
#import "NSData+Base64.h"

@implementation AJSerializer

#pragma mark - public method
+ (NSData *)jsonDataWithObject:(id)object
{
    id basicObject = [AJSerializer serializeToBasicObject:object];
    return [NSJSONSerialization dataWithJSONObject:basicObject options:0 error:nil];
}

+ (NSString *)jsonStringWithObject:(id)object
{
    NSString *jsonString = [[NSString alloc] initWithData:[AJSerializer jsonDataWithObject:object] encoding:NSUTF8StringEncoding];
    return jsonString;
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
    
    // now, we are step into customized object zone
    NSDictionary *propertiesMap = [AJClassHelper reflectProperties:[rawObject class]];
    NSMutableDictionary *result = [NSMutableDictionary new];
    for (AJPropertyDescriptor *propertyDescriptor in propertiesMap.allValues) {
        id property = [rawObject valueForKey:propertyDescriptor.propertyName];
        
        if (propertyDescriptor.propertyType > AJDataTypeJsonableObject && propertyDescriptor.propertyType < AJDataTypePrimitiveType) {
            result[propertyDescriptor.propertyName] = [AJSerializer jsonableObject:property dataType:propertyDescriptor.propertyType];
        }
        
        if (propertyDescriptor.propertyType > AJDataTypePrimitiveType && propertyDescriptor.propertyType < AJDataTypeComplicateType) {
            result[propertyDescriptor.propertyName] = [AJSerializer jsonablePrimitiveValue:property dataType:propertyDescriptor.propertyType];
        }
        
        if (propertyDescriptor.propertyType > AJDataTypeComplicateType && propertyDescriptor.propertyType < AJDataTypeCustomizedObject) {
            result[propertyDescriptor.propertyName] = [AJSerializer jsonableComplicateValue:property dataType:propertyDescriptor.propertyType];
        }
        
        if (propertyDescriptor.propertyType == AJDataTypeCustomizedObject) {
            result[propertyDescriptor.propertyName] = [AJSerializer serializeToBasicObject:property];
        }
    }
    return result;
}

+ (id)jsonableComplicateValue:(id)rawObject dataType:(AJDataType)dataType
{
    if (dataType == AJDataTypeCharString) {
        NSLog(@"%@", rawObject);
    }
    return @"N/A";
}

+ (id)jsonablePrimitiveValue:(id)rawObject dataType:(AJDataType)dataType
{
    if (dataType == AJDataTypeChar) {
        char charString[] = {[rawObject charValue], '\0'};
        return [NSString stringWithCString:charString encoding:NSUTF8StringEncoding];
    }
    
    if (dataType == AJDataTypeCPPBool) {
        return @([rawObject boolValue]);
    }
    
    return @([rawObject integerValue]);
}

+ (id)jsonableObject:(id)rawObject dataType:(AJDataType)dataType
{
    if (dataType == AJDataTypeNSArray) {
        NSMutableArray *result = [NSMutableArray new];
        for (id item in rawObject) {
            [result addObject:[AJSerializer serializeToBasicObject:item]];
        }
        return result;
    }
    
    if (dataType == AJDataTypeNSDictionary) {
        NSMutableDictionary *result = [NSMutableDictionary new];
        for (id key in [rawObject allKeys]) {
            NSString *propertyKey;
            if ([key isKindOfClass:[NSString class]]) {
                propertyKey = key;
            } else {
                propertyKey = [NSString stringWithFormat:@"%@^%@", [NSString stringWithCString:object_getClassName(key) encoding:NSUTF8StringEncoding], [NSUUID UUID].UUIDString];
            }
            
            id item = rawObject[key];
            result[propertyKey] = [AJSerializer serializeToBasicObject:item];
        }
        return result;
    }
    
    if (dataType == AJDataTypeNSDate) {
        return @((unsigned long long)([rawObject timeIntervalSince1970]*1000));
    }
    
    if (dataType == AJDataTypeNSData) {
        return [rawObject base64EncodedString];
    }
    
    if (dataType == AJDataTypeNSNumber) {
        return rawObject;
    }
    
    if (dataType == AJDataTypeNSString) {
        return rawObject;
    }
    
    return [NSNull null];
}

@end
