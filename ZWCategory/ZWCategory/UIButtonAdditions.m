//
//  UIButtonAdditions.m
//  ALHomeland
//
//  Created by kiwi on 8/23/13.
//  Copyright (c) 2013 xizue. All rights reserved.
//

#import "UIButtonAdditions.h"
#import "UIImageAdditions.h"

@implementation UIButton (Additions)

+ (UIButton*)roundedRectButtonWithTitle:(NSString*)title color:(UIColor*)color raduis:(CGFloat)raduis {
    // Prepare
    UIFont * font = [UIFont boldSystemFontOfSize:16];
    UIImage * bkgN = [UIImage imageWithColor:color cornerRadius:raduis];
    UIImage * bkgD = [UIImage imageWithColor:[color colorWithAlphaComponent:0.45] cornerRadius:raduis];
    NSDictionary * attributes = @{NSFontAttributeName:font};
    CGSize size = [title sizeWithAttributes:attributes];
    // Generate Button
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, size.width + 30, 35);
    [btn setBackgroundImage:bkgN forState:UIControlStateNormal];
    [btn setBackgroundImage:bkgD forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = font;
    return btn;
}

+ (UIButton*)borderButtonWithTitle:(NSString*)title color:(UIColor*)color raduis:(CGFloat)raduis {
    // Prepare
    UIColor * normalColor = color;
    UIColor * highlightedColor = [color colorWithAlphaComponent:0.35];
    UIFont * font = [UIFont boldSystemFontOfSize:15];
//    UIImage * bkgN = [UIImage imageWithColor:normalColor cornerRadius:raduis lineWidth:1];
//    UIImage * bkgD = [UIImage imageWithColor:highlightedColor cornerRadius:raduis lineWidth:1];
    NSDictionary * attributes = @{NSFontAttributeName:font};
    CGSize size = [title sizeWithAttributes:attributes];
    // Generate Button
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, size.width + 30, 35);
//    [btn setBackgroundImage:bkgN forState:UIControlStateNormal];
//    [btn setBackgroundImage:bkgD forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = font;
    btn.layer.cornerRadius = raduis;
    btn.layer.borderColor = normalColor.CGColor;
    btn.layer.borderWidth = 1;
    return btn;
}

@end
