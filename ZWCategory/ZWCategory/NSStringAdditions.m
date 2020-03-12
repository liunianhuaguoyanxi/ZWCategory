//
//  NSStringAdditions.m
//  Weibo
//
//  Created by junmin liu on 10-9-29.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSStringAdditions.h"

@implementation NSString (Additions)

- (BOOL)hasValue {
    return ([self isKindOfClass:[NSString class]] && self.length > 0);
}
- (BOOL)isUrl

{
    NSString *baseURL = [self lowercaseString];
    if ([baseURL hasPrefix:@"http://"]||[baseURL hasPrefix:@"https://"]||[baseURL hasPrefix:@"ftp://"]) {
        NSString *regex =@"^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&%\\$\\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(cn|com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\?\'\\\\+&%\\$#\\=~_\\-]+))*$";
        NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [urlTest evaluateWithObject:baseURL];
    }else
    {
        NSString *regex =@"^(((ht|f)tp(s?))\\://)?(www.|[a-zA-Z].)[a-zA-Z0-9\\-\\.]+\\.(cn|com|edu|gov|mil|net|org|biz|info|name|museum|us|ca|uk)(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\;\?\'\\\\+&%\\$#\\=~_\\-]+))*$";
        NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [urlTest evaluateWithObject:baseURL];
    }
    //    NSString *regex =@"http://|ftp://|https://|www)[^\u4e00-\u9fa5\\s]*?\\.(com|net|cn|me|tw|fr)[^\u4e00-\u9fa5\\s]*";
    //    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //    return [urlTest evaluateWithObject:self];
    
}
- (BOOL)isPhone {
    BOOL res = NO;
    if (self.hasValue) {
        NSInteger count = self.length;
        if ([self hasPrefix:@"+"]) {
            count = count - 1;
        }
        NSString * numbers = [self numbersFormat];
        res = numbers.length == count;
        if (res) {
            if ([self hasPrefix:@"1"]) {
                res = (self.length == 11) && (numbers.length == 11);
            } else if ([self hasPrefix:@"+"]) {
                res = (self.length == 14) && (numbers.length == 13);
            } else {
                res = NO;
            }
        }
    }
    return res;
}
- (BOOL)isTelephone {
    BOOL res = NO;
    if (self.hasValue) {
        if ([[self numbersFormat] isEqualToString:self]) {
            res = YES;
        }
    }
    return res;
}
- (BOOL)isEmail {
    BOOL res = NO;
    if (self.hasValue) {
        if (!self.hasChineseWords) {
            NSRange rangeAt = [self rangeOfString:@"@"];
            if (rangeAt.location != NSNotFound) {
                NSArray * arr = [self componentsSeparatedByString:@"@"];
                if ([arr isKindOfClass:[NSArray class]] && arr.count == 2) {
                    NSString * prefix = [arr objectAtIndex:0];
                    if (prefix.hasValue && !([prefix isEqualToString:@"@"] && [prefix isEqualToString:@"."])) {
                        NSString * suffix = [arr lastObject];
                        NSRange rangePoint = [suffix rangeOfString:@"."];
                        if (rangePoint.location != NSNotFound && rangePoint.location > 0 && rangePoint.location < suffix.length - 1) {
                            NSArray * pointArr = [suffix componentsSeparatedByString:@"."];
                            BOOL notHasValue = NO;
                            for (NSString * str in pointArr) {
                                if (!str.hasValue) {
                                    notHasValue = YES;
                                    break;
                                }
                            }
                            if (!notHasValue) {
                                res = YES;
                            }
                        }
                    }
                }
            }
        }
//        BOOL characterChecked = !self.hasChineseWords;
//        
//        if (characterChecked) {
//            NSRegularExpression * reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w+)+)$" options:NSRegularExpressionCaseInsensitive error:nil];
//            if (reg) {
//                res = YES;
//                if ([reg rangeOfFirstMatchInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)].length != self.length) {
//                    res = NO;
//                }
//            }
//        }
    }
    return res;
}
- (BOOL)hasChineseWords {
    BOOL res = NO;
    for (NSInteger i = 0; i < self.length; i ++) {
        NSString * characterStr = [self substringWithRange:NSMakeRange(i, 1)];
        const char * cstr = [characterStr UTF8String];
        if (strlen(cstr) > 1) {
            res = YES;
            break;
        }
    }
    return res;
}
- (BOOL)isChineseIDCard {
    BOOL res = NO;
    if (self.hasValue) {
        NSString * numbers = [self numbersFormat];
        if ([self hasSuffix:@"x"] || [self hasSuffix:@"X"]) {
            if (numbers.hasValue) {
                res = (numbers.length == 14 || numbers.length == 17);
            }
        } else {
            if (numbers.hasValue) {
                res = (numbers.length == 15 || numbers.length == 18);
            }
        }
    }
    return res;
}

- (NSString*)singleLineString {
    NSString * res = [self stringByReplacingOccurrencesOfString:@"\r" withString:@"  "];
    return [res stringByReplacingOccurrencesOfString:@"\n" withString:@"  "];
}

+ (NSString *)generateGuid {
	CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
	//get the string representation of the UUID
	NSString * uuidString = CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
	return uuidString;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceAndNewlines {
	NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	for (NSInteger i = 0; i < self.length; ++i) {
		unichar c = [self characterAtIndex:i];
		if (![whitespace characterIsMember:c]) {
			return NO;
		}
	}
	return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isEmptyOrWhitespace {
	return self == nil || !self.length ||
	![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}




///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
	NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in [query keyEnumerator]) {
		NSString* value = [query objectForKey:key];
		value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
		value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
		NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
		[pairs addObject:pair];
	}
	
	NSString* params = [pairs componentsJoinedByString:@"&"];
	if ([self rangeOfString:@"?"].location == NSNotFound) {
		return [self stringByAppendingFormat:@"?%@", params];
	} else {
		return [self stringByAppendingFormat:@"&%@", params];
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSComparisonResult)versionStringCompare:(NSString *)other {
	NSArray *oneComponents = [self componentsSeparatedByString:@"a"];
	NSArray *twoComponents = [other componentsSeparatedByString:@"a"];
	
	// The parts before the "a"
	NSString *oneMain = [oneComponents objectAtIndex:0];
	NSString *twoMain = [twoComponents objectAtIndex:0];
	
	// If main parts are different, return that result, regardless of alpha part
	NSComparisonResult mainDiff;
	if ((mainDiff = [oneMain compare:twoMain]) != NSOrderedSame) {
		return mainDiff;
	}
	
	// At this point the main parts are the same; just deal with alpha stuff
	// If one has an alpha part and the other doesn't, the one without is newer
	if ([oneComponents count] < [twoComponents count]) {
		return NSOrderedDescending;
	} else if ([oneComponents count] > [twoComponents count]) {
		return NSOrderedAscending;
	} else if ([oneComponents count] == 1) {
		// Neither has an alpha part, and we know the main parts are the same
		return NSOrderedSame;
	}
	
	// At this point the main parts are the same and both have alpha parts. Compare the alpha parts
	// numerically. If it's not a valid number (including empty string) it's treated as zero.
	NSNumber *oneAlpha = [NSNumber numberWithInt:[[oneComponents objectAtIndex:1] intValue]];
	NSNumber *twoAlpha = [NSNumber numberWithInt:[[twoComponents objectAtIndex:1] intValue]];
	return [oneAlpha compare:twoAlpha];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)md5Hash {
	return [[self dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
}
- (NSString*)md5Caps {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5Caps];
}

- (BOOL)validateCharacter:(NSString*)chars {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:chars];
    
    int i = 0;
    while (i < self.length) {
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


- (NSString *)replaceHtml {
    NSString *result = self;
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:result];
    
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL];
        [theScanner scanUpToString:@">" intoString:&text];
        result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    result = [result stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    result = [result stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    result = [result stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    result = [result stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    result = [result stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    return result;
}

- (NSString *)numbersFormat {
//    NSString * originStr = [NSString stringWithFormat:@"%@",self];
//    NSMutableString * strippedString = [NSMutableString stringWithCapacity:originStr.length];
//    NSScanner * scanner = [NSScanner scannerWithString:originStr];
//    NSCharacterSet * numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//    while ([scanner isAtEnd] == NO) {
//        NSString * buffer;
//        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
//            [strippedString appendString:buffer];
//        } else {
//            [scanner setScanLocation:([scanner scanLocation] + 1)];
//        }
//    }
//    return strippedString;
    return [self filteredWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]];
}

- (NSString *)filteredWithAllowedCharacters:(NSCharacterSet*)characterSet {
    NSString * originStr = [self copy];
    if (![characterSet isKindOfClass:[NSCharacterSet class]]) return originStr;
    NSMutableString * strippedString = [NSMutableString stringWithCapacity:originStr.length];
    NSScanner * scanner = [NSScanner scannerWithString:originStr];
    while ([scanner isAtEnd] == NO) {
        NSString * buffer;
        if ([scanner scanCharactersFromSet:characterSet intoString:&buffer]) {
            [strippedString appendString:buffer];
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    return strippedString;
}

+ (BOOL)isFloatNumber:(NSString *)strValue
{
    if ([strValue isEqualToString:@""]||strValue == NULL||strValue == nil ) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:strValue];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (NSString *)KSGetStrBetweenStartStr:(NSString *)startStr andEndStr:(NSString *)endStr inResourceString:(NSString *)resourceString
{
    NSRange start = [resourceString rangeOfString:startStr];
    
    NSRange end = [resourceString rangeOfString:endStr];
    
    NSUInteger location = start.location + start.length;
    NSUInteger length = end.location - start.location - start.length;
    if (length >= 0) {
        NSRange range = NSMakeRange(location, length);
        
        NSString *result = [resourceString substringWithRange:range];
        return result;
    }
    else
    {
        return nil;
    }
    
    
}

+ (NSString *)KSReplaceSpaceAndNewline:(NSString *)str WithSeleltedStr:(NSString *)seleltedStr{
    
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:seleltedStr];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:seleltedStr];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:seleltedStr];
    return temp;
}

@end
