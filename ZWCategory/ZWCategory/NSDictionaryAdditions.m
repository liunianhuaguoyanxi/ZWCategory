//
//  NSDictionaryAdditions.m
//  WeiboPad
//
//  Created by junmin liu on 10-10-6.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "NSDictionaryAdditions.h"


@implementation NSDictionary (Additions)

- (BOOL)getBOOLValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    id tmpValue = [self objectForKey:key];
    
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return defaultValue;
    }
    
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue boolValue];
    } else {
        @try {
            return [tmpValue boolValue];
        }
        @catch (NSException *exception) {
            NSLog(@"getBoolValueForKey : %@",key);
            NSLog(@"tmpValue : %@",tmpValue);
            return defaultValue;
        }
    }
}

- (NSInteger)getIntegerValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue {
    id tmpValue = [self objectForKey:key];
    
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return defaultValue;
    }
    
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue integerValue];
    } else {
        @try {
            return [tmpValue integerValue];
        }
        @catch (NSException *exception) {
            NSLog(@"getIntValueForKey : %@",key);
            NSLog(@"tmpValue : %@",tmpValue);
            return defaultValue;
        }
    }
}

- (float)getFloatValueForKey:(NSString *)key defaultValue:(float)defaultValue {
    id tmpValue = [self objectForKey:key];
    
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return defaultValue;
    }
    
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue floatValue];
    } else {
        @try {
            return [tmpValue floatValue];
        }
        @catch (NSException *exception) {
            NSLog(@"getFloatValueForKey : %@",key);
            NSLog(@"tmpValue : %@",tmpValue);
            return defaultValue;
        }
    }
}

- (double)getDoubleValueForKey:(NSString *)key defaultValue:(double)defaultValue {
    id tmpValue = [self objectForKey:key];
    
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return defaultValue;
    }
    
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue doubleValue];
    } else {
        @try {
            return [tmpValue doubleValue];
        }
        @catch (NSException *exception) {
            NSLog(@"getFloatValueForKey : %@",key);
            NSLog(@"tmpValue : %@",tmpValue);
            return defaultValue;
        }
    }
}

- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue {
    NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null]) {
        stringTime = @"";
    }
    struct tm created;
    time_t now;
    time(&now);
    
    if (stringTime) {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
            strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        return mktime(&created);
    }
    return defaultValue;
}

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
    id tmpValue = [self objectForKey:key];
    
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return defaultValue;
    }
    
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue longLongValue];
    } else {
        @try {
            return [tmpValue longLongValue];
        }
        @catch (NSException *exception) {
            NSLog(@"getLongLongValueValueForKey : %@",key);
            NSLog(@"tmpValue : %@",tmpValue);
            return defaultValue;
        }
    }
}

- (long)getLongValueValueForKey:(NSString *)key defaultValue:(long)defaultValue {
    id tmpValue = [self objectForKey:key];
    
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return defaultValue;
    }
    
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue longValue];
    } else {
        @try {
            return [tmpValue longValue];
        }
        @catch (NSException *exception) {
            NSLog(@"getLongLongValueValueForKey : %@",key);
            NSLog(@"tmpValue : %@",tmpValue);
            return defaultValue;
        }
    }
}

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    id tmpValue = [self objectForKey:key];
    
    if (tmpValue == nil || tmpValue == [NSNull null] || ([tmpValue isKindOfClass:[NSString class]] && [tmpValue isEqualToString:@"null"])) {
        return [defaultValue stringByReplacingOccurrencesOfString:@"</lineend>" withString:@"\n"];
    }
    
    if ([tmpValue isKindOfClass:[NSString class]]) {
        return [[NSString stringWithString:tmpValue] stringByReplacingOccurrencesOfString:@"</lineend>" withString:@"\n"];
    } else {
        @try {
            return [[NSString stringWithFormat:@"%@",tmpValue] stringByReplacingOccurrencesOfString:@"</lineend>" withString:@"\n"];
        }
        @catch (NSException *exception) {
            NSLog(@"getStringValueForKey : %@",key);
            NSLog(@"tmpValue : %@",tmpValue);
            return defaultValue;
        }
    }
}

- (NSNumber *)getNumberValueForKey:(NSString *)key defaultValue:(double)defaultValue {
    id tmpValue = [self objectForKey:key];
    
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return [NSNumber numberWithDouble:defaultValue];
    }
    
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return tmpValue;
    } else {
        @try {
            return [NSNumber numberWithDouble:[tmpValue doubleValue]];
        }
        @catch (NSException *exception) {
            NSLog(@"getNumberValueForKey : %@", key);
            NSLog(@"tmpValue : %@", tmpValue);
            return [NSNumber numberWithDouble:defaultValue];
        }
    }
}

- (NSDictionary*)getDictionaryForKey:(NSString*)key {
    id tmpValue = [self objectForKey:key];
    if ([tmpValue isKindOfClass:[NSDictionary class]]) {
        return tmpValue;
    } else {
        return nil;
    }
}

- (NSArray*)getArrayForKey:(NSString*)key {
    id tmpValue = [self objectForKey:key];
    if ([tmpValue isKindOfClass:[NSArray class]]) {
        return tmpValue;
    } else {
        return nil;
    }
}

@end
