//
//  AJClassHelper.h
//  AnyJson
//
//  Created by casa on 14-9-20.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AJPropertyType) {
    
    AJPropertyTypeError = 0,
    
    // JSONable class types
    AJPropertyTypeJsonableObject = 100,
    AJPropertyTypeNSArray = 101,
    AJPropertyTypeNSDictionary = 102,
    AJPropertyTypeNSDate = 103,
    AJPropertyTypeNSData = 104,
    AJPropertyTypeNSString = 105,
    AJPropertyTypeNSNumber = 106,
    
    // primitive types
    AJPropertyTypePrimitiveType = 200,
    AJPropertyTypeChar = 201,
    AJPropertyTypeDouble = 202,
    AJPropertyTypeFloat = 203,
    AJPropertyTypeInt = 204,
    AJPropertyTypeLong = 205,
    AJPropertyTypeShort = 206,
    AJPropertyTypeUnsigned = 207,
    AJPropertyTypeLongLong = 208,
    AJPropertyTypeUnsignedChar = 209,
    AJPropertyTypeUnsignedShort = 210,
    AJPropertyTypeUnsignedLong = 211,
    AJPropertyTypeUnsignedLongLong = 212,
    AJPropertyTypeCPPBool = 213,
    
    // hard for me to transform, but I will work it out
    AJPropertyTypeComplicateType = 220,
    AJPropertyTypeArray = 221,
    AJPropertyTypeStructure = 222,
    AJPropertyTypeUnion = 223,
    AJPropertyTypeBitField = 224,
    AJPropertyTypeCharString = 215,
    AJPropertyTypeVoid = 216,
    
    // hmmm...harder...
    AJPropertyTypeHarderType = 240,
    AJPropertyTypeSelector = 241,
    AJPropertyTypeClass = 242,
    AJPropertyTypePointer = 243,
    AJPropertyTypeUnknownType = 244, // sometimes it could be a function pointer
    
    // other objects which can not be transformed to JSON directly
    AJPropertyTypeCustomizedObject = 301,
};

@interface AJClassHelper : NSObject

+ (NSDictionary *)reflectProperties:(Class)clazz;

+ (Class)classFromPropertyAttributeString:(NSString *)propertyAttributeString;
+ (AJPropertyType)propertyTypeFromPropertyAttributeString:(NSString *)propertyAttributeString;

@end
