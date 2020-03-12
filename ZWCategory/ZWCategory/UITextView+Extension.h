//
//  UITextView+Extension.h
//  ZW微博
//
//  Created by liunianhuaguoyanxi on 15/12/23.
//  Copyright (c) 2015年 liunianhuaguoyanxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
-(void)insertAttributedText:(NSAttributedString *)text;
-(void)insertAttributedText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString * attributedText))settingBlock;
@end
