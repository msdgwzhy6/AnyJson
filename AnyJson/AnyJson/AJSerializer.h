//
//  AJTransformer.h
//  AnyJson
//
//  Created by casa on 14-9-19.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AJSerializable;

@interface AJSerializer : NSObject

+ (NSData *)jsonDataWithObject:(id<AJSerializable>)object;
+ (NSString *)jsonStringWithObject:(id<AJSerializable>)object;

+ (id)objectWithJsonString:(NSString *)jsonString;

@end
