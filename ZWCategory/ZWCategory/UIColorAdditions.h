//
//  UIColorAdditions.h
//  CCFramework
//
//  Created by kiwi on 11/29/13.
//  Copyright (c) 2013 Kiwi Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColorAdditions)

/**
 * 用十六进制方式初始化UIColor，FFFFFFFF白色，000000FF黑色，最后两位为透明度
 */
+ (UIColor *)colorFromHexCode:(NSString *)hexString;

@end
