//
//  AJClassHelper.m
//  AnyJson
//
//  Created by casa on 14-9-20.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import "AJClassHelper.h"
#import <objc/runtime.h>
#import "AJPropertyDescriptor.h"

@implementation AJClassHelper

+ (NSDictionary *)reflectProperties:(Class)clazz
{
    Class superClass = [clazz superclass];
    NSDictionary *superClassPropertyMap = nil;
    if (superClass != NULL && superClass != [NSObject class]) {
        superClassPropertyMap = [AJClassHelper reflectProperties:superClass];
    }
    
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(clazz, &outCount);
    NSMutableDictionary *propertyMap = [[NSMutableDictionary alloc] initWithDictionary:superClassPropertyMap];
    
    for (int index = 0; index < outCount; index++) {
        const char *propertyName = property_getName(propertyList[index]);
        NSString *propertyNameString = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        
        const char *propertyAttribute = property_getAttributes(propertyList[index]);
        NSString *propertyAttributeString = [NSString stringWithCString:propertyAttribute encoding:NSUTF8StringEncoding];
        
        AJPropertyDescriptor *propertyDescriptor = [[AJPropertyDescriptor alloc] initWithPropertyNameString:propertyNameString propertyAttributeString:propertyAttributeString];
        propertyMap[propertyNameString] = propertyDescriptor;
    }
    
    free(propertyList);
    
    return propertyMap;
}

+ (Class)classFromPropertyAttributeString:(NSString *)propertyAttributeString
{
    return nil;
}

+ (AJPropertyType)propertyTypeFromPropertyAttributeString:(NSString *)propertyAttributeString
{
    return 0;
}

@end
