//
//  UIImage+Alpha.h
//  CCFramework
//
//  Created by kiwi on 11/29/13.
//  Copyright (c) 2013 Kiwi Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Alpha)

- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (UIImage *)imageWithShadow:(UIColor*)_shadowColor
                  shadowSize:(CGSize)_shadowSize
                        blur:(CGFloat)_blur;

- (UIImage *)maskWithColor:(UIColor *)color;

- (UIImage *)maskWithColor:(UIColor *)color
               shadowColor:(UIColor *)shadowColor
              shadowOffset:(CGSize)shadowOffset
                shadowBlur:(CGFloat)shadowBlur;

- (UIImage*)KSImageWithTintColor:(UIColor*)color;
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

- (UIImage*)blackWhite;

@end
