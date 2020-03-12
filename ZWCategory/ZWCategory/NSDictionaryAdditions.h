//
//  NSDictionaryAdditions.h
//  CCFramework
//
//  Created by junmin liu on 10-10-6.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (Additions)

/**
 * 从NSDictionary实例中解析布尔值
 */
- (BOOL)getBOOLValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
/**
 * 从NSDictionary实例中解析整型
 */
- (NSInteger)getIntegerValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
/**
 * 从NSDictionary实例中解析浮点型
 */
- (float)getFloatValueForKey:(NSString*)key defaultValue:(float)defaultValue;
/**
 * 从NSDictionary实例中解析长浮点型
 */
- (double)getDoubleValueForKey:(NSString *)key defaultValue:(double)defaultValue;
- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;
/**
 * 从NSDictionary实例中解析长整型
 */
- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
/**
* 从NSDictionary实例中解析长整型
*/
- (long)getLongValueValueForKey:(NSString *)key defaultValue:(long)defaultValue;
/**
 * 从NSDictionary实例中解析字符串
 */
- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
/**
 * 从NSDictionary实例中解析NSNumber型
 */
- (NSNumber *)getNumberValueForKey:(NSString *)key defaultValue:(double)defaultValue;

/**
 * 从NSDictionary实例中解析NSDictionary实例，如果不存在或者类型不对，返回nil
 */
- (NSDictionary*)getDictionaryForKey:(NSString*)key;
/**
 * 从NSDictionary实例中解析NSArray实例，如果不存在或者类型不对，返回nil
 */
- (NSArray*)getArrayForKey:(NSString*)key;

@end
