//
//  NSStringAdditions.h
//  CCFramework
//
//  Created by junmin liu on 10-9-29.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDataAdditions.h"


/**
 * Doxygen does not handle categories very well, so please refer to the .m file in general
 * for the documentation that is reflected on api.three20.info.
 */
@interface NSString (Additions)
@property (readonly) BOOL isUrl;// 判断String是否是URL
@property (readonly) BOOL hasValue;// 判断String是否有值
@property (readonly) BOOL isPhone;// 判断String是否是中国手机号码
@property (readonly) BOOL isTelephone;// 判断String是否是座机号码
@property (readonly) BOOL isEmail;// 判断String是否是邮箱地址
@property (readonly) BOOL hasChineseWords;// 判断String是否含有汉字
@property (readonly) BOOL isChineseIDCard;// 判断String是否是身份证号
@property (readonly) NSString * singleLineString;// 判断String是否是身份证号

// 判断String是否是实数
+ (BOOL)isFloatNumber:(NSString *)strValue;

+ (NSString *)generateGuid;
/**
 * Determines if the string contains only whitespace and newlines.
 */
- (BOOL)isWhitespaceAndNewlines;

/**
 * Determines if the string is empty or contains only whitespace.
 */
- (BOOL)isEmptyOrWhitespace;


/**
 * Parses a URL, adds query parameters to its query, and re-encodes it as a new URL.
 */
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;

/**
 * Compares two strings expressing software versions.
 *
 * The comparison is (except for the development version provisions noted below) lexicographic
 * string comparison. So as long as the strings being compared use consistent version formats,
 * a variety of schemes are supported. For example "3.02" < "3.03" and "3.0.2" < "3.0.3". If you
 * mix such schemes, like trying to compare "3.02" and "3.0.3", the result may not be what you
 * expect.
 *
 * Development versions are also supported by adding an "a" character and more version info after
 * it. For example "3.0a1" or "3.01a4". The way these are handled is as follows: if the parts
 * before the "a" are different, the parts after the "a" are ignored. If the parts before the "a"
 * are identical, the result of the comparison is the result of NUMERICALLY comparing the parts
 * after the "a". If the part after the "a" is empty, it is treated as if it were "0". If one
 * string has an "a" and the other does not (e.g. "3.0" and "3.0a1") the one without the "a"
 * is newer.
 *
 * Examples (?? means undefined):
 *   "3.0" = "3.0"
 *   "3.0a2" = "3.0a2"
 *   "3.0" > "2.5"
 *   "3.1" > "3.0"
 *   "3.0a1" < "3.0"
 *   "3.0a1" < "3.0a4"
 *   "3.0a2" < "3.0a19"  <-- numeric, not lexicographic
 *   "3.0a" < "3.0a1"
 *   "3.02" < "3.03"
 *   "3.0.2" < "3.0.3"
 *   "3.00" ?? "3.0"
 *   "3.02" ?? "3.0.3"
 *   "3.02" ?? "3.0.2"
 */
- (NSComparisonResult)versionStringCompare:(NSString *)other;

/**
 * Calculate the md5 hash of this string using CC_MD5.
 *
 * @return md5 hash of this string
 */
@property (nonatomic, readonly) NSString* md5Hash;// 包含小写字母的MD5值

@property (nonatomic, readonly) NSString* md5Caps;// 包含大写字母的MD5值

- (BOOL)validateCharacter:(NSString*)chars;

- (NSString *) replaceHtml;

- (NSString *)numbersFormat;

- (NSString *)filteredWithAllowedCharacters:(NSCharacterSet*)characterSet;
// 获取两字符串之间的内容
+ (NSString *)KSGetStrBetweenStartStr:(NSString *)startStr andEndStr:(NSString *)endStr inResourceString:(NSString *)resourceString;

+ (NSString *)KSReplaceSpaceAndNewline:(NSString *)str WithSeleltedStr:(NSString *)seleltedStr;
@end
