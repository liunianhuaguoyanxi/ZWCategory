//
//  NSDateAdditions.h
//  CCFramework
//
//  Created by kiwi on 5/31/13.
//  Copyright (c) 2013 Kiwi Private. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

/**
 * 将"yyyy-MM-dd HH:mm:ss"这样的日期格式转换为NSDate实例
 */
+ (NSDate*)dateFromString:(NSString*)uiDate;
/**
 * 将任意的日期格式转换为NSDate实例
 */
+ (NSDate*)dateFromString:(NSString*)uiDate formatter:(NSString*)formatter;

/**
 * 将1970时间戳转换为标准完整的时间格式
 */

+ (NSString*)standardDateStringFromTimeInterval:(NSTimeInterval)interval;





+ (NSString*)stringFromMinutestToHoursAndMinutes:(long long)minutes;

//与现在的时间差 格式HH：mm
+ (NSString*)stringFromTimeIntervalFromNow:(NSTimeInterval)interval;
//格式HH：mm
+ (NSString*)stringFromTimeIntervalHHmm:(NSTimeInterval)interval;
//分钟转换 格式HH：mm
+ (NSString*)stringFromTimeIntervalHHmmWithMinutes:(long)minutes;
//与现在的时间差 YES则超时
+ (BOOL)stringFromTimeIntervalFromNowTimeOut:(NSTimeInterval)interval;
/**
 * 将NSDate实例以任意日期格式转换为字符串
 */
- (NSString*)stringFromDate:(NSString*)format;

/**
 * 将NSDate实例以"yyyy-MM-dd"日期格式转换为字符串
 */
- (NSString*)stringFromDateYMD;
- (NSString*)stringFromDateYMDHMS;

- (int)yearsPastFromNow;
- (int)daysPastFromNow;
- (NSDate *)dateThisWeek;

/**
 * 时间格式为 h:mm
 如果为昨天则展示：昨天 h:mm
 如果更早：yyyy-M-d h:mm
 */
+ (NSString *)formatTime:(NSTimeInterval)timeInterval;

@end
