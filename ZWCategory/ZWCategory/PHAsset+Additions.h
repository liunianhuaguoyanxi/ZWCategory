//
//  PHAsset+Additions.h
//  EweiHelp
//
//  Created by 流年划过颜夕 on 2019/4/15.
//  Copyright © 2019 infocare. All rights reserved.
//

#import <Photos/Photos.h>


typedef void(^ZWPHAssetResultCompletionBlock) (UIImage * _Nullable image, NSDictionary * _Nullable info ,NSTimeInterval  latestTime);

NS_ASSUME_NONNULL_BEGIN

@interface PHAsset (Additions)
/**
 *  获取最新一张图片
 */
+ (void)latestAssetWithSize:(CGSize)size WithResult:(ZWPHAssetResultCompletionBlock)value;
@end

NS_ASSUME_NONNULL_END
