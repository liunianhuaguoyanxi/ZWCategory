//
//  NSDataAdditions.h
//  CCFramework
//
//  Created by junmin liu on 10-9-29.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSData (Addtions)

/**
 * Calculate the md5 hash of this data using CC_MD5.
 *
 * @return 包含小写字母的MD5值
 */
@property (nonatomic, readonly) NSString * md5Hash;

/**
 * Calculate the md5 hash of this data using CC_MD5.
 *
 * @return 包含大写字母的MD5值
 */
@property (nonatomic, readonly) NSString * md5Caps;


@end