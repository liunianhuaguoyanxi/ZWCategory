//
//  NSMutableArray+Additions.m
//  EweiHelp
//
//  Created by Kiwi on 16/6/15.
//  Copyright © 2016年 infocare. All rights reserved.
//

#import "NSMutableArray+Additions.h"

@implementation NSMutableArray (Additions)

- (void)addObject:(id)anObject defaultValue:(id)defaultValue {
    if (anObject) {
        [self addObject:anObject];
    } else {
        if (defaultValue == nil) defaultValue = @"-";
        [self addObject:defaultValue];
    }
}
- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}
@end
