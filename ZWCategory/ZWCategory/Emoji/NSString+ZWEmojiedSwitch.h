//
//  NSString+ZWEmojiedSwitch.h
//
//  Created by 流年划过颜夕 on 2018/12/3.
//  Copyright © 2018年 com.yihe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZWEmojiedSwitch)
//微信表情编码转unicode码
+ (NSString *)ZWEmojizedUnicodeWithWeiChatCodeText:(NSString *)originText;
//unicode码转微信表情编码
+ (NSString *)ZWEmojizedWeiChatCodeWithUnicodeText:(NSString *)originText;
@end

