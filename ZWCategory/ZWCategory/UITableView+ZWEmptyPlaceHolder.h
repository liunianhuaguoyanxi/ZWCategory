//
//  UITableView+ZWEmptyPlaceHolder.h
//  EweiHelp
//
//  Created by 流年划过颜夕 on 2018/4/13.
//  Copyright © 2018年 infocare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ZWEmptyPlaceHolder)

- (void) tableViewDisplayView:(UIView *)displayView ifNecessaryForRowCount:(NSUInteger) rowCount withKeyWord:(NSString *)keyword;
@end
