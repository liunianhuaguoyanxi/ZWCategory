//
//  UILabelAdditions.m
//  ALHomeland
//
//  Created by kiwi on 8/21/13.
//  Copyright (c) 2013 xizue. All rights reserved.
//

#import "UILabelAdditions.h"
#import "math.h"

@implementation UILabel (Additions)

+ (__kindof UILabel*)singleLineText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid {
    return [self singleLineText:text font:font wid:wid color:[UIColor blackColor]];
}
+ (__kindof UILabel*)singleLineText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid color:(UIColor*)color {
    return [self linesText:text font:font wid:wid lines:1 color:color];
}

+ (__kindof UILabel*)multLinesText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid {
    return [self multLinesText:text font:font wid:wid color:[UIColor blackColor]];
}
+ (__kindof UILabel*)multLinesText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid color:(UIColor*)color {
    return [self linesText:text font:font wid:wid lines:0 color:color];
}

+ (__kindof UILabel*)linesText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid lines:(int)lines {
    return [self linesText:text font:font wid:wid lines:lines color:[UIColor blackColor]];
}
+ (__kindof UILabel*)linesText:(NSString*)text font:(UIFont*)font wid:(CGFloat)wid lines:(int)lines color:(UIColor*)color {
    CGFloat maxH = 0;
    if (lines > 0) {
        maxH = (font.pointSize + 2) * lines + 4;
    } else {
        maxH = 6000;
    }
    CGSize size = CGSizeMake(wid, maxH);
    
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraph.alignment = NSTextAlignmentLeft;
    if (lines == 1) {
        paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
    } else {
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    }
    NSDictionary * attr = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraph};
    size = [text length] > 0 ? [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attr context:nil].size : CGSizeZero;
    UILabel * lab = [[[self class] alloc] initWithFrame:CGRectMake(0, 0, size.width, ceilf(size.height))];
    lab.numberOfLines = lines;
    lab.backgroundColor = [UIColor clearColor];
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = color;
    lab.font = font;
    lab.text = text;
//    lab.highlightedTextColor = [UIColor whiteColor];
    return lab;
}

+ (__kindof UILabel*)labWithWidth:(CGFloat)wid font:(UIFont*)font {
    return [self labWithWidth:wid font:font color:[UIColor blackColor]];
}
+ (__kindof UILabel*)labWithWidth:(CGFloat)wid font:(UIFont*)font color:(UIColor*)color {
    CGFloat width = wid;
    if (width <= 0) width = 20;
    UILabel * lab = [[[self class] alloc] initWithFrame:CGRectMake(0, 0, width, font.lineHeight)];
    lab.numberOfLines = 1;
    lab.backgroundColor = [UIColor clearColor];
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = color;
    lab.font = font;
    return lab;
}

@end
