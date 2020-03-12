//
//  NSString+ZWEmojiedSwitch.m
//
//  Created by 流年划过颜夕 on 2018/12/3.
//  Copyright © 2018年 com.yihe. All rights reserved.
//

#import "NSString+ZWEmojiedSwitch.h"
#import "ZWEmojisDescribtion.h"
#import "ZWEmojisSBCodeToUnicode.h"
#import "ZWEmojisUnicodeToSBCode.h"
#import <Foundation/Foundation.h>
@implementation NSString (Emojize)


+ (NSString *)ZWEmojizedUnicodeWithWeiChatCodeText:(NSString *)originText
{
    
    if (originText.length>0&&![originText isEqualToString:@"null"]){
        static dispatch_once_t onceToken;
        static NSRegularExpression *regex = nil;
        dispatch_once(&onceToken, ^{
            regex = [[NSRegularExpression alloc] initWithPattern:@"(\\#\\[1\\|[0-9]{1,10}\\])" options:NSRegularExpressionCaseInsensitive error:NULL];
        });
        __block NSString *resultText = originText;
        NSRange matchingRange = NSMakeRange(0, [resultText length]);
        [regex enumerateMatchesInString:resultText options:NSMatchingReportCompletion range:matchingRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            if (result && ([result resultType] == NSTextCheckingTypeRegularExpression) && !(flags & NSMatchingInternalError)) {
                NSRange range = result.range;
                if (range.location != NSNotFound) {
                    
                    NSString *weiChatCode = [originText substringWithRange:range];
                    
                    if ([weiChatCode isKindOfClass:[NSString class]] && weiChatCode.length > 0) {
                        
                        int sbCodeNumbet = [NSString hexStringWithWeiChatCode:weiChatCode];
                        NSString *sbCode = [NSString stringWithFormat:@"%X",sbCodeNumbet];
                        NSString *unicode = self.ZWEmojisSBCodeToUnicode[sbCode];
                        
                        if (unicode) {
                            
                            resultText = [resultText stringByReplacingOccurrencesOfString:weiChatCode withString:unicode];
                        }else
                        {
                            NSString *sbCodeNumStr = nil;
                            sbCodeNumStr = [NSString stringWithFormat:@"\\u%x",sbCodeNumbet];
                            sbCodeNumStr = [NSString replaceUnicode:sbCodeNumStr];
                            resultText = [resultText stringByReplacingOccurrencesOfString:@"]‍♀️" withString:@"]"];
                            resultText = [resultText stringByReplacingOccurrencesOfString:@"]‍" withString:@"]"];
                            
                            resultText = [resultText stringByReplacingOccurrencesOfString:weiChatCode withString:sbCodeNumStr];
                            
                        }
                    }
                }
            }
        }];
        
        return resultText;
    }
    else
    {
        return originText;
    }
    
    
}



+(NSString *)replaceUnicode:(NSString*)unicodeStr{
    NSString *tempStr1=[unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2=[tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3=[[@"\"" stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData=[tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr =[NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}




+ (NSString *)emojiTextFromSBUnicode:(NSString*)emojiText {
    // convert emoji text to SB Unicode
    
    NSString * result = nil;
    
    NSString * item = self.ZWEmojisSBCodeToUnicode[emojiText];
    if ([item isKindOfClass:[NSString class]] && item.length > 0) {
        
        result = item;
        
    }
    
    return result;
}
+ (NSString *)ZWEmojizedWeiChatCodeWithUnicodeText:(NSString *)originText
{
    
    if (originText.length>0&&![originText isEqualToString:@"null"]){
        static dispatch_once_t onceToken;
        static NSRegularExpression *regexUnicodeText = nil;
        dispatch_once(&onceToken, ^{
            regexUnicodeText = [[NSRegularExpression alloc] initWithPattern:@"[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\ud83e\\udd00-\\ud83e\\udfff]|[\\u2600-\\u27ff]|[\\u2B55]|[\\u2122]|[\\u00AE]|[\\u00A9]" options:NSRegularExpressionCaseInsensitive error:NULL];
        });
        __block NSString *resultText = originText;
        NSRange matchingRange = NSMakeRange(0, [resultText length]);
        [regexUnicodeText enumerateMatchesInString:resultText options:NSMatchingReportCompletion range:matchingRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            if (result && ([result resultType] == NSTextCheckingTypeRegularExpression) && !(flags & NSMatchingInternalError)) {
                NSRange range = result.range;
                if (range.location != NSNotFound) {
                    
                    NSString *sbCode = [originText substringWithRange:range];
                    
                    if ([sbCode isKindOfClass:[NSString class]] && sbCode.length > 0) {
                        
                        NSString *weiChat = self.ZWEmojisUnicodeToSBCode[sbCode];
                        
                        NSString *weiChatCode = [NSString weiChatCodeWithHexString:weiChat];
                        
                        if (weiChatCode) {
                            resultText = [resultText stringByReplacingOccurrencesOfString:sbCode withString:weiChatCode];
                        }
                        
                        
                    }
                }
            }
        }];
        
        return resultText;
    }
    else
    {
        return originText;
    }
    
    
}



//微信格式十进制转十六进制
+ (int)hexStringWithWeiChatCode:(NSString *)hexNumberStr{
    if (hexNumberStr.length>5) {
        hexNumberStr = [hexNumberStr substringFromIndex:4];
        hexNumberStr = [hexNumberStr substringToIndex:hexNumberStr.length-1];
        return [hexNumberStr intValue];
    }else
    {
        return [hexNumberStr intValue];
    }
    
}
//十六进制转十进制微信格式
+ (NSString *)weiChatCodeWithHexString:(NSString *)hexString{
    
    if (hexString.length>0) {
        const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
        int hexNumber;
        sscanf(hexChar, "%X", &hexNumber);
        return [NSString stringWithFormat:@"#[1|%lD]",(long)hexNumber];
    }else
    {
        return hexString;
    }
    
}


+ (NSDictionary *)emojiAliases {
    static NSDictionary *_emojiAliases;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _emojiAliases = ZWEmojisDescribtion_HASH;
        
    });
    return _emojiAliases;
}

+ (NSDictionary *)ZWEmojisSBCodeToUnicode {
    static NSDictionary *_ZWEmojisSBCodeToUnicode;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ZWEmojisSBCodeToUnicode = ZWEmojisSBCodeToUnicode_HASH;
        
    });
    
    
    
    return _ZWEmojisSBCodeToUnicode;
}
+ (NSDictionary *)ZWEmojisUnicodeToSBCode {
    static NSDictionary *_ZWEmojisUnicodeToSBCode;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ZWEmojisUnicodeToSBCode = ZWEmojisUnicodeToSBCode_HASH;
        
    });
    
    
    return _ZWEmojisUnicodeToSBCode;
}


//扫码遗漏
//+ (NSString *)ZWEmojizedUnicodeWithWeiChatCodeText:(NSString *)originText
//{
//
//    NSString * result = originText;
//    NSScanner * theScanner;
//    NSString * text = nil;
//    theScanner = [NSScanner scannerWithString:result];
//
//    while ([theScanner isAtEnd] == NO) {
//        [theScanner scanUpToString:@"#[1|" intoString:NULL];
//        [theScanner scanUpToString:@"]" intoString:&text];
//        if ([text isKindOfClass:[NSString class]] && text.length > 0) {
//
//            // get decimal number
//            // convert to hexadecimal
//            // to unicode string
//            NSString * decimalNumberText = [text substringFromIndex:4];
//
//            decimalNumberText = [NSString getNumberWithUnicodeStr:decimalNumberText];
//            NSString * unicodeText = [NSString stringWithFormat:@"%X", [decimalNumberText intValue]];
//
//            // to unicode
//            NSString * emojiText = [NSString emojiTextFromSBUnicode:unicodeText];
//            // if not supported
//            if ([emojiText isEqualToString:@""]||(emojiText ==nil)) {
//                emojiText = [NSString stringWithFormat:@"\\u%x",[decimalNumberText intValue]];
//                NSString *tmpStr = [text substringFromIndex:text.length-1];
//
//                if (![NSString isPureInt:tmpStr]) {
//
//                    emojiText = [NSString replaceUnicode:emojiText];
//
////                    NSLog(@"未识别特殊字符 %@",text);
////                    NSLog(@"未识别特殊字符 %@",emojiText);
//
//                    result = [result stringByReplacingOccurrencesOfString:text withString:emojiText];
//                }else
//                {
////                 NSLog(@"未识别特殊字符11 %@",text);
//                emojiText = [NSString replaceUnicode:emojiText];
//                // replace item in origin string
//                result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"#[1|%@]",decimalNumberText] withString:emojiText];
//                }
//
//            }
//            else{
//            // replace item in origin string
//            result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@]",text] withString:emojiText];
//            }
//
//        }
//    }
//
//    return result;
//}

//+ (BOOL)isPureInt:(NSString *)string{
//    NSScanner* scan = [NSScanner scannerWithString:string];
//    int val;
//    return [scan scanInt:&val] && [scan isAtEnd];
//}

//+(NSString *)getNumberWithUnicodeStr:(NSString*)unicodeStr
//{
//    NSScanner *scanner = [NSScanner scannerWithString:unicodeStr];
//
//    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
//
//
//
//    int number;
//
//    [scanner scanInt:&number];
//
//    return [NSString stringWithFormat:@"%d",number];
//}

//匹配缺失
//+ (NSString *)ZWEmojizedWeiChatCodeWithUnicodeText:(NSString *)text
//
//{
//
//    if (text.length>0 &&![text isEqualToString:@"null"]) {
//        __block NSString *resultText = text;
//        [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
//
//                                 options:NSStringEnumerationByComposedCharacterSequences
//
//                              usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
//
//                                  const unichar hs = [substring characterAtIndex:0];
//
//                                  if (0xd800 <= hs && hs <= 0xdbff) {
//
//                                      if (substring.length > 1) {
//
//                                          const unichar ls = [substring characterAtIndex:1];
//
//                                          const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
//
//                                          if (0x1d000 <= uc && uc <= 0x1f77f) {
//                                              NSString *sbcode = self.ZWEmojisUnicodeToSBCode[substring];
//                                              if (sbcode.length>0) {
//                                                  NSString *weiChatCode = [NSString weiChatCodeWithHexString:sbcode];
//                                                  resultText = [resultText stringByReplacingOccurrencesOfString:substring withString:weiChatCode];
//                                              }
//
//                                          }
//
//                                      }
//
//                                  } else if (substring.length > 1) {
//
//                                      const unichar ls = [substring characterAtIndex:1];
//
//                                      if (ls == 0x20e3) {
//                                          NSString *sbcode = self.ZWEmojisUnicodeToSBCode[substring];
//                                          if (sbcode.length>0) {
//                                              NSString *weiChatCode = [NSString weiChatCodeWithHexString:sbcode];
//                                              resultText = [resultText stringByReplacingOccurrencesOfString:substring withString:weiChatCode];
//                                          }
//                                      }
//
//                                  } else {
//
//                                      if (0x2100 <= hs && hs <= 0x27ff) {
//                                          NSString *sbcode = self.ZWEmojisUnicodeToSBCode[substring];
//                                          if (sbcode.length>0) {
//                                              NSString *weiChatCode = [NSString weiChatCodeWithHexString:sbcode];
//                                              resultText = [resultText stringByReplacingOccurrencesOfString:substring withString:weiChatCode];
//                                          }
//                                      } else if (0x2B05 <= hs && hs <= 0x2b07) {
//                                          NSString *sbcode = self.ZWEmojisUnicodeToSBCode[substring];
//                                          if (sbcode.length>0) {
//                                              NSString *weiChatCode = [NSString weiChatCodeWithHexString:sbcode];
//                                              resultText = [resultText stringByReplacingOccurrencesOfString:substring withString:weiChatCode];
//                                          }
//                                      } else if (0x2934 <= hs && hs <= 0x2935) {
//                                          NSString *sbcode = self.ZWEmojisUnicodeToSBCode[substring];
//                                          if (sbcode.length>0) {
//                                              NSString *weiChatCode = [NSString weiChatCodeWithHexString:sbcode];
//                                              resultText = [resultText stringByReplacingOccurrencesOfString:substring withString:weiChatCode];
//                                          }
//                                      } else if (0x3297 <= hs && hs <= 0x3299) {
//                                          NSString *sbcode = self.ZWEmojisUnicodeToSBCode[substring];
//                                          if (sbcode.length>0) {
//                                              NSString *weiChatCode = [NSString weiChatCodeWithHexString:sbcode];
//                                              resultText = [resultText stringByReplacingOccurrencesOfString:substring withString:weiChatCode];
//                                          }
//                                      } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
//                                          NSString *sbcode = self.ZWEmojisUnicodeToSBCode[substring];
//                                          if (sbcode.length>0) {
//                                              NSString *weiChatCode = [NSString weiChatCodeWithHexString:sbcode];
//                                              resultText = [resultText stringByReplacingOccurrencesOfString:substring withString:weiChatCode];
//                                          }
//                                      }
//
//                                  }
//
//                              }];
//
//        return resultText;
//    }
//    else
//    {
//        return text;
//    }
//
//}
@end

