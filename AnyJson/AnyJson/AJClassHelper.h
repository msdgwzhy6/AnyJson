//
//  AJClassHelper.h
//  AnyJson
//
//  Created by casa on 14-9-20.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AJPropertyType) {
    // JSONable class types
    AJPropertyTypeArray = 100,
    AJPropertyTypeDictionary = 101,
    AJPropertyTypeDate = 102,
    AJPropertyTypeData = 103,
    AJPropertyTypeString = 104,
    AJPropertyTypeNumber = 105,
    
    // primitive types
    AJPropertyTypeInteger = 201,
    AJPropertyTypeChar = 202,
    AJPropertyTypeFloat = 203,
    
    // customized type
    AJPropertyTypeCustomizedType = 301
};

@interface AJClassHelper : NSObject

+ (NSDictionary *)reflectProperties:(Class)clazz;

+ (Class)classFromPropertyAttributeString:(NSString *)propertyAttributeString;
+ (AJPropertyType)propertyTypeFromPropertyAttributeString:(NSString *)propertyAttributeString;

@end
