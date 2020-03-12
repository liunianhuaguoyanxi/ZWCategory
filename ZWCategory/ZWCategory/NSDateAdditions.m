//
//  NSDateAdditions.m
//  LifeInChengdu
//
//  Created by kiwi on 5/31/13.
//  Copyright (c) 2013 xizue. All rights reserved.
//

#import "NSDateAdditions.h"
//#import "KSDateComponent.h"

@implementation NSDate (Additions)

+ (NSDate*)dateFromString:(NSString*)uiDate {
    return [NSDate dateFromString:uiDate formatter:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate*)dateFromString:(NSString*)uiDate formatter:(NSString*)fmt {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fmt];
    NSDate * date = [formatter dateFromString:uiDate];
    return date;
}

+ (NSString*)standardDateStringFromTimeInterval:(NSTimeInterval)interval {
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    NSString * timeFormatter;
    // 12-hours style
    if (hasAMPM) {
        timeFormatter = @"h:mm a";
    } else {// 24-hours style
        timeFormatter = @"H:mm";
    }
    NSString * formatter = [NSString stringWithFormat:@"yyyy-M-d %@", timeFormatter];
    return [[NSDate dateWithTimeIntervalSince1970:interval] stringFromDate:formatter];
}




//格式HH：mm
+ (NSString*)stringFromTimeIntervalHHmm:(NSTimeInterval)interval {
    NSString * _timestamp;
    NSString *tmphhStr;
    NSString *tmpmmStr;
    long distance = (long)interval;
    
    if ((distance>0 &&distance<3600)||(distance<=0 &&distance>-3600)) {
        tmphhStr = @"";
    }else
    {
        long tmphh = distance/3600;
        
        tmphh= labs(tmphh);
        
        tmphhStr = [NSString stringWithFormat:@"%ld 小时 ",tmphh];
    }
    int tmpmm = (distance/60)%60;
    tmpmm = abs(tmpmm);
    if (tmpmm == 0) {
        tmpmmStr = @"";
    }else
    {
        tmpmmStr = [NSString stringWithFormat:@"%d 分钟",tmpmm];
    }
    if (distance > 0) {
        _timestamp=[NSString stringWithFormat:@"%@%@",tmphhStr,tmpmmStr];
    }else
    {
        _timestamp=[NSString stringWithFormat:@"超时 %@%@",tmphhStr,tmpmmStr];
    }

    return _timestamp;
}

+ (NSString*)stringFromTimeIntervalFromNow:(NSTimeInterval)interval {
    NSString * _timestamp;
    time_t now;
    time(&now);
    NSString *tmphhStr;
    NSString *tmpmmStr;
    long distance = (long)difftime(interval, now);
    
    if ((distance>0 &&distance<3600)||(distance<=0 &&distance>-3600)) {
        tmphhStr = @"";
    }else
    {
        long tmphh = distance/3600;
        
        tmphh= labs(tmphh);
        
        tmphhStr = [NSString stringWithFormat:@"%ld 小时 ",tmphh];
    }
    int tmpmm = (distance/60)%60;
    tmpmm = abs(tmpmm);
    if (tmpmm == 0) {
        if ([tmphhStr isEqualToString:@""]) {
            tmpmmStr = @"0 分钟";
        }else
        {
            tmpmmStr = @"";
        }
    }else
    {
        tmpmmStr = [NSString stringWithFormat:@"%d 分钟",tmpmm];
    }
    if (distance > 0) {
        _timestamp=[NSString stringWithFormat:@"%@%@",tmphhStr,tmpmmStr];
    }else
    {
        _timestamp=[NSString stringWithFormat:@"超时 %@%@",tmphhStr,tmpmmStr];
    }

    return _timestamp;
}

//格式HH：mm 分钟转换
+ (NSString*)stringFromTimeIntervalHHmmWithMinutes:(long)minutes
{
    NSString * _timestamp;
    NSString *tmphhStr;
    NSString *tmpmmStr;
    long distance = (long)minutes*60;
    
    if ((distance>0 &&distance<3600)||(distance<=0 &&distance>-3600)) {
        tmphhStr = @"";
    }else
    {
        long tmphh = distance/3600;
        
        tmphh= labs(tmphh);
        
        tmphhStr = [NSString stringWithFormat:@"%ld 小时 ",tmphh];
    }
    int tmpmm = (distance/60)%60;
    tmpmm = abs(tmpmm);
    if (tmpmm == 0) {
        if ([tmphhStr isEqualToString:@""]) {
            tmpmmStr = @"0 分钟";
        }else
        {
            tmpmmStr = @"";
        }
    }else
    {
        tmpmmStr = [NSString stringWithFormat:@"%d 分钟",tmpmm];
    }

    _timestamp=[NSString stringWithFormat:@"%@%@",tmphhStr,tmpmmStr];

    return _timestamp;
}

//分钟转小时分钟
+ (NSString*)stringFromMinutestToHoursAndMinutes:(long long)minutes {
    NSString * _timestamp;
    if (minutes > 0) {
        NSString *tmphhStr;
        NSString *tmpmmStr;
        if ((minutes>0 &&minutes<60)||(minutes<=0 &&minutes>-60)) {
            tmphhStr = @"";
        }else
        {
            long long tmphh = minutes/60;
            
            tmphh= llabs(tmphh);
            
            tmphhStr = [NSString stringWithFormat:@"%lld 小时 ",tmphh];
        }
        
        int tmpmm = minutes%60;
        tmpmm = abs(tmpmm);
        if (tmpmm == 0) {
            tmpmmStr = @"";
        }else
        {
            tmpmmStr = [NSString stringWithFormat:@"%d 分钟",tmpmm];
        }

        
        _timestamp=[NSString stringWithFormat:@"%@%@",tmphhStr,tmpmmStr];
    }else
    {
        _timestamp = @"-";
    }

    return _timestamp;
}

+ (BOOL)stringFromTimeIntervalFromNowTimeOut:(NSTimeInterval)interval {
    BOOL isTimeOut;
    time_t now;
    time(&now);
    long distance = (long)difftime(interval, now);
    if (distance>0) {
        isTimeOut = NO;
    }else
    {
        isTimeOut = YES;
    }
    


    return isTimeOut;
}
- (NSString*)stringFromDate:(NSString*)format {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString * res = [formatter stringFromDate:self];
    if ([res hasPrefix:@"0"]) {
        res = [res substringFromIndex:1];
    }
    return res;
}

- (NSString*)stringFromDateYMD {
    return [self stringFromDate:@"yyyy-MM-dd"];
}
- (NSString*)stringFromDateYMDHMS {
    return [self stringFromDate:@"yyyy-MM-dd HH:mm:ss"];
}

- (int)yearsPastFromNow {
    NSString * pastDate = [self stringFromDate:@"yyyy"];
    NSString * nowDate = [[NSDate date] stringFromDate:@"yyyy"];
    return ([nowDate intValue]-[pastDate intValue]);
}
- (int)daysPastFromNow {
    NSString * pastDate = [self stringFromDate:@"yyyy"];
    NSString * nowDate = [[NSDate date] stringFromDate:@"yyyy"];
    return ([nowDate intValue]-[pastDate intValue]);
}
/**
 获取包含年月日的NSDateComponents
 */
- (NSDateComponents *)weekDateCompontents {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:[[NSDate alloc] init]];
    
    return components;
}

- (NSDate *)dateThisWeek {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [self weekDateCompontents];
    
    // week:2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六) 1(星期天)
    NSInteger weekDay = components.weekday - 1;
    //几号
    NSInteger day = components.day;
    // 计算当前日期和这周的星期一和星期天差的天数
    NSInteger firstDiff,lastDiff;
    if (weekDay == 0) {
        firstDiff = -6;
        lastDiff = 0;
    } else {
        firstDiff = cal.firstWeekday - weekDay;
        lastDiff = 7 - weekDay;
    }
    
    NSDateComponents *firstDayComp = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[[NSDate alloc] init]];
    [firstDayComp setDay:(day+firstDiff)];
    NSDate *firstDayOfWeek= [cal dateFromComponents:firstDayComp];
    
    return firstDayOfWeek;
}
+ (NSString *)formatTime:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    if ([date isToday]) {
        if([date isJustNow]) {
            return @"刚刚";
        }else {
            formatter.dateFormat = @"HH:mm";
            return [formatter stringFromDate:date];
        }
    }else{
        if ([date isYesterday]) {
            formatter.dateFormat = @"昨天HH:mm";
            return [formatter stringFromDate:date];
        }else if ([date isCurrentWeek]){
            formatter.dateFormat = [NSString stringWithFormat:@"%@%@",[date dateToWeekday],@"HH:mm"];
            return [formatter stringFromDate:date];
        }else{
            if([date isCurrentYear]) {
                formatter.dateFormat = @"MM-dd  HH:mm";
            }else {
                formatter.dateFormat = @"yy-MM-dd  HH:mm";
            }
            return [formatter stringFromDate:date];
        }
    }
    return nil;
}

- (BOOL)isJustNow {
    NSTimeInterval now = [[NSDate new] timeIntervalSince1970];
    return fabs(now - self.timeIntervalSince1970) < 60 * 2 ? YES : NO;
}

- (BOOL)isCurrentWeek {
    NSDate *nowDate = [[NSDate date] dateFormatYMD];
    NSDate *selfDate = [self dateFormatYMD];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day <= 7;
}

- (BOOL)isCurrentYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    return selfComponents.year == nowComponents.year;
}

- (NSString *)dateToWeekday {
    NSArray *weekdays = [NSArray arrayWithObjects: @"", @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

- (BOOL)isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.day == nowComponents.day);
}

- (BOOL)isYesterday {
    NSDate *nowDate = [[NSDate date] dateFormatYMD];
    NSDate *selfDate = [self dateFormatYMD];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)dateFormatYMD {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}
@end
