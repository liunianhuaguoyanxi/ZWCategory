//
//  PHAsset+Additions.m
//  EweiHelp
//
//  Created by 流年划过颜夕 on 2019/4/15.
//  Copyright © 2019 infocare. All rights reserved.
//

#import "PHAsset+Additions.h"

@implementation PHAsset (Additions)
+ (void)latestAssetWithSize:(CGSize)size WithResult:(ZWPHAssetResultCompletionBlock)value{
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];

    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    PHAsset *phasset = [assetsFetchResults firstObject];
    
    if (phasset) {
        PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
        
        
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        options.resizeMode = PHImageRequestOptionsResizeModeFast;

        options.synchronous = YES;
        
        NSTimeInterval secondsBetweenDates = [[NSDate date]  timeIntervalSinceDate:phasset.creationDate];
        if (secondsBetweenDates < 0) {
            secondsBetweenDates = 0;
        }
        NSLog(@"secondsBetweenDates  %F", secondsBetweenDates );
        
        [imageManager requestImageForAsset:phasset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            if (downloadFinined) {
                return  value(result,info,secondsBetweenDates);
            }
            else
            {
                return  value(nil,nil,9000);
            }

            
        }];
    }else
    {
        
        return  value(nil,nil,9000);
    }


}
@end
