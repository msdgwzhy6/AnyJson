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
    NSRange range = [propertyAttributeString rangeOfString:@","];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    NSString *typeString = [propertyAttributeString substringToIndex:range.location];
    if ([typeString hasPrefix:@"T@\""]) {
        NSUInteger length = typeString.length;
        return NSClassFromString([typeString substringWithRange:NSMakeRange(3, length - 4)]);
    }
    
    return nil;
}

+ (AJPropertyType)propertyTypeFromPropertyAttributeString:(NSString *)propertyAttributeString
{
    NSRange range = [propertyAttributeString rangeOfString:@","];
    if (range.location == NSNotFound) {
        return AJPropertyTypeError;
    }
    
    NSString *typeString = [propertyAttributeString substringToIndex:range.location];
    
    if ([typeString hasPrefix:@"T@"]) {
        NSUInteger length = typeString.length;
        Class clazz = NSClassFromString([typeString substringWithRange:NSMakeRange(3, length - 4)]);
        if (clazz == [NSArray class] || clazz == [NSMutableArray class]) {
            return AJPropertyTypeNSArray;
        }
        if (clazz == [NSDictionary class] || clazz == [NSMutableDictionary class]) {
            return AJPropertyTypeNSDictionary;
        }
        if (clazz == [NSString class] || clazz == [NSMutableString class]) {
            return AJPropertyTypeNSString;
        }
        if (clazz == [NSDate class]) {
            return AJPropertyTypeNSDate;
        }
        if (clazz == [NSData class] || clazz == [NSMutableData class]) {
            return AJPropertyTypeNSData;
        }
        if (clazz == [NSNumber class]) {
            return AJPropertyTypeNSNumber;
        }
        
        return AJPropertyTypeCustomizedObject;
    }
    
    if ([typeString hasPrefix:@"Tc"]) {
        return AJPropertyTypeChar;
    }
    if ([typeString hasPrefix:@"Td"]) {
        return AJPropertyTypeDouble;
    }
    if ([typeString hasPrefix:@"Ti"]) {
        return AJPropertyTypeInt;
    }
    if ([typeString hasPrefix:@"Tf"]) {
        return AJPropertyTypeFloat;
    }
    if ([typeString hasPrefix:@"Tl"]) {
        return AJPropertyTypeLong;
    }
    if ([typeString hasPrefix:@"Ts"]) {
        return AJPropertyTypeShort;
    }
    if ([typeString hasPrefix:@"T{"]) {
        return AJPropertyTypeStructure;
    }
    if ([typeString hasPrefix:@"TI"]) {
        return AJPropertyTypeUnsigned;
    }
    if ([typeString hasPrefix:@"T^?"] || [typeString hasPrefix:@"T?"]) {
        return AJPropertyTypeUnknownType;
    }
    if ([typeString hasPrefix:@"Tv"]) {
        return AJPropertyTypeVoid;
    }
    if ([typeString hasPrefix:@"Tq"]) {
        return AJPropertyTypeLongLong;
    }
    if ([typeString hasPrefix:@"TC"]) {
        return AJPropertyTypeUnsignedChar;
    }
    if ([typeString hasPrefix:@"TS"]) {
        return AJPropertyTypeUnsignedShort;
    }
    if ([typeString hasPrefix:@"TL"]) {
        return AJPropertyTypeUnsignedLong;
    }
    if ([typeString hasPrefix:@"TQ"]) {
        return AJPropertyTypeUnsignedLongLong;
    }
    if ([typeString hasPrefix:@"TB"]) {
        return AJPropertyTypeCPPBool;
    }
    if ([typeString hasPrefix:@"T*"]) {
        return AJPropertyTypeCharString;
    }
    if ([typeString hasPrefix:@"T#"]) {
        return AJPropertyTypeClass;
    }
    if ([typeString hasPrefix:@"T:"]) {
        return AJPropertyTypeSelector;
    }
    if ([typeString hasPrefix:@"T["]) {
        return AJPropertyTypeArray;
    }
    if ([typeString hasPrefix:@"T{"]) {
        return AJPropertyTypeStructure;
    }
    if ([typeString hasPrefix:@"T("]) {
        return AJPropertyTypeUnion;
    }
    if ([typeString hasPrefix:@"Tb"]) {
        return AJPropertyTypeBitField;
    }
    if ([typeString hasPrefix:@"T^"]) {
        return AJPropertyTypePointer;
    }
    
    return AJPropertyTypeError;
}

@end
