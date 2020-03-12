//
//  NSMutableArray+Additions.h
//  EweiHelp
//
//  Created by Kiwi on 16/6/15.
//  Copyright © 2016年 infocare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Additions)

- (void)addObject:(id)anObject defaultValue:(id)defaultValue;
- (id)objectAtIndexCheck:(NSUInteger)index;
@end
