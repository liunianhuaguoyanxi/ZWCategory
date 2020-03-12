//
//  UITableView+ZWEmptyPlaceHolder.m
//  EweiHelp
//
//  Created by 流年划过颜夕 on 2018/4/13.
//  Copyright © 2018年 infocare. All rights reserved.
//

#import "UITableView+ZWEmptyPlaceHolder.h"

@implementation UITableView (ZWEmptyPlaceHolder)
- (void) tableViewDisplayView:(UIView *)displayView ifNecessaryForRowCount:(NSUInteger) rowCount withKeyWord:(NSString *)keyword
{
    if (rowCount == 0&&([keyword isKindOfClass:[NSString class]] && keyword.length > 0)) {
        self.backgroundView = displayView;
    } else {
        self.backgroundView = nil;

    }
}
@end
