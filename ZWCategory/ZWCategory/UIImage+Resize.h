//
//  UIImage+Resize.h
//  CCFramework
//
//  Created by kiwi on 11/29/13.
//  Copyright (c) 2013 Kiwi Private. All rights reserved.
//

#ifndef UKIMAGE_H
#define UKIMAGE_H

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage*)rotate:(UIImageOrientation)orient;
- (UIImage*)resizeImageWithNewSize:(CGSize)newSize;

/**
 * 压缩图片分辨率，参数maxL为最大长宽
 */
- (UIImage*)resizeImageGreaterThan:(CGFloat)maxL;

@end

#endif  // UKIMAGE_H 