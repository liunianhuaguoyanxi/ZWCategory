//
//  UITextView+Extension.m
//  ZW微博
//
//  Created by liunianhuaguoyanxi on 15/12/23.
//  Copyright (c) 2015年 liunianhuaguoyanxi. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
-(void)insertAttributedText:(NSAttributedString *)text
{
    //[self.textView insertText:emotion.png];
    // UIImage *image=[UIImage imageNamed:emotion.png];
    [self insertAttributedText:text settingBlock:nil];


}
-(void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    NSMutableAttributedString *attributedText=[[NSMutableAttributedString alloc]init];
    [attributedText appendAttributedString:self.attributedText];
    
    
    NSUInteger loc=self.selectedRange.location;
    //[attributedText insertAttributedString:text atIndex:loc];
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    if (settingBlock) {
        settingBlock(attributedText);
    }
    self.attributedText=attributedText;
    self.selectedRange=NSMakeRange(loc+1, 0);
}
@end
