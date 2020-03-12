//
//  UIImage+RoundedCorner.h
//  CCFramework
//
//  Created by kiwi on 11/29/13.
//  Copyright (c) 2013 Kiwi Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedCorner)

- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

- (UIImage*)imageWithRadius:(float)radius 
					  width:(float)width
					 height:(float)height;

- (UIImage*)imageWithRadius:(float)radius;

@end
