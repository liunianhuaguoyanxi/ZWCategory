//
//  UIImageAdditions.m
//  BusinessMate
//
//  Created by kiwi on 6/5/13.
//  Copyright (c) 2013 xizue. All rights reserved.
//

#import "UIImageAdditions.h"

@implementation UIImage (Additions)

+ (UIImage *)imageWithNoCache:(NSString*)name {
    NSString * type = nil;
    if ([name rangeOfString:@"."].location == NSNotFound) {
        type = @"png";
    }
    NSString * path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)rotateImage:(UIImage *)aImage {
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

// Render a UIImage at the specified size. This is needed to render out the resizable image mask before sending it to maskImage:withMask:
- (UIImage *)renderAtSize:(const CGSize)size {
    UIGraphicsBeginImageContext(size);
    const CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextScaleCTM(context, 2, 2);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    const CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *renderedImage = [UIImage imageWithCGImage:cgImage scale:2 orientation:UIImageOrientationUp];
//    UIImage *renderedImage = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    UIGraphicsEndImageContext();
    
    return renderedImage;
}

- (UIImage *)maskWithImage:(const UIImage *) maskImage {
    UIImage * image = self;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageRef maskImageRef = [maskImage CGImage];
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    if (mainViewContentContext==NULL)
        return NULL;
    
    CGFloat ratio = 0;
    
    ratio = maskImage.size.width / image.size.width;
    
    if(ratio * image.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ image.size.height;
    }
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};
    CGRect rect2  = {{-((image.size.width*ratio)-maskImage.size.width)/2 , -((image.size.height*ratio)-maskImage.size.height)/2}, {image.size.width*ratio, image.size.height*ratio}};
    
    
    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, image.CGImage);
    
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    // return the image
    return theImage;
}

CGContextRef NYXImageCreateARGBBitmapContext(const size_t width, const size_t height, const size_t bytesPerRow) {
    /// Use the generic RGB color space
    /// We avoid the NULL check because CGColorSpaceRelease() NULL check the value anyway, and worst case scenario = fail to create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    /// Create the bitmap context, we want pre-multiplied ARGB, 8-bits per component
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8/*Bits per component*/, bytesPerRow, colorSpace, 1);
    
    CGColorSpaceRelease(colorSpace);
    
    return bmContext;
}

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius lineWidth:(CGFloat)lineWidth {
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = lineWidth;
    roundedRect.lineCapStyle = kCGLineCapButt;
    roundedRect.lineJoinStyle = kCGLineJoinMiter;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
//    [[UIColor whiteColor] setFill];
//    [roundedRect fill];
    [color setStroke];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}


- (CGFloat) DegreesToRadians:(CGFloat) degrees {
    return degrees * M_PI / 180;
}

- (CGFloat) RadiansToDegrees:(CGFloat) radians {
    return radians * 180/M_PI;
}

- (UIImage *)imageRotatedByRadians:(CGFloat)radians {
    return [self imageRotatedByDegrees:[self RadiansToDegrees:radians]];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation([self DegreesToRadians:degrees ]);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContextWithOptions(rotatedSize, NO, self.scale);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, [self DegreesToRadians:degrees ]);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)backArrowImageWithText:(NSString *)text {
    CGSize sizeMain = CGSizeMake(14, 23);
    CGSize sizeImage = CGSizeMake(10, 19);
    CGSize sizeText = CGSizeZero;
    NSMutableDictionary * text_attributes = nil;
    
    if ([text isKindOfClass:[NSString class]] && text.length > 0) {
        UIFont * font = [UIFont systemFontOfSize:17];
        NSMutableParagraphStyle * paraStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paraStyle.alignment = NSTextAlignmentLeft;
        NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
        [attributes setObject:font forKey:NSFontAttributeName];
        [attributes setObject:paraStyle forKey:NSParagraphStyleAttributeName];
        [attributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        sizeText = [text sizeWithAttributes:attributes];
        text_attributes = attributes;
        sizeMain.width += sizeText.width + 6;
    }
    CGPoint point = CGPointMake(2, (sizeMain.height - sizeImage.height) / 2 + 1);
    point.x += sizeImage.width;
    UIGraphicsBeginImageContextWithOptions(sizeMain, NO, 0.0);
    
    // Draw
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(con, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(con, 3);
    CGContextMoveToPoint(con, point.x, point.y);
    CGContextAddLineToPoint(con, point.x - sizeImage.width, point.y + sizeImage.height / 2);
    CGContextAddLineToPoint(con, point.x, point.y + sizeImage.height);
    CGContextStrokePath(con);
    
    if ([text isKindOfClass:[NSString class]] && text.length > 0) {
        CGRect rect;
        rect.origin = CGPointMake(2 + sizeImage.width + 6, (sizeMain.height - sizeText.height) / 2);
        rect.size = sizeText;
        [text drawInRect:rect withAttributes:text_attributes];
    }
    
    UIImage * resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
