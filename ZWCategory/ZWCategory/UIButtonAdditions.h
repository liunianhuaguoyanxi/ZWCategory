//
//  UIButtonAdditions.h
//  CCFramework
//
//  Created by kiwi on 8/23/13.
//  Copyright (c) 2013 Kiwi Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton (Additions)

/**
 * 返回指定背景色的UIButton，默认高度为35
 */
+ (UIButton*)roundedRectButtonWithTitle:(NSString*)title color:(UIColor*)color raduis:(CGFloat)raduis;

+ (UIButton*)borderButtonWithTitle:(NSString*)title color:(UIColor*)color raduis:(CGFloat)raduis;

@end
