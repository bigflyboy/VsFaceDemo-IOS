//
//  gpu.h
//  gpu
//
//  Created by 王志远 on 2017/6/7.
//  Copyright © 2017年 王志远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

//! Project version number for gpu.
FOUNDATION_EXPORT double gpuVersionNumber;

//! Project version string for gpu.
FOUNDATION_EXPORT const unsigned char gpuVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <gpu/PublicHeader.h>


@interface gpu : NSObject
///	初始化
-(id)init:(UIView*)preview;
-(void)helloA;
@end
