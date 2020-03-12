//
//  UILabel+Extension.h
//  fictionary
//
//  Created by 流年划过颜夕 on 16/9/5.
//  Copyright © 2016年 tommin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
