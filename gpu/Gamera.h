//
//  Gamera.h
//  VsFaceDemo
//
//  Created by 王志远 on 2017/6/7.
//  Copyright © 2017年 王志远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>



@protocol GameraSampleDelegate<NSObject>
-(CMSampleBufferRef)preVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer;
@end



@interface Gamera : NSObject<AVCaptureVideoDataOutputSampleBufferDelegate>
@property(nonatomic, assign)id<GameraSampleDelegate> sampleDelegate;

///////////////////////////////////////////////////////////
///	初始化
-(id)init:(UIView*)preview;

///////////////////////////////////////////////////////////
///	设置处理模式（mode），目前支持：
/// "": 通路测试
/// "tuner": 美颜
/// "facer": 美颜+人脸检测
-(void*)gpuMode:(NSString*)mode;

///////////////////////////////////////////////////////////
///	开启、关闭：返回机位序号，<0 代表失败，0/1 代表后置/前置
-(int)open:(BOOL)front width:(int)w height:(int)h;
-(int)switching;
-(int)close;

-(int)active;

///////////////////////////////////////////////////////////
/// 修改相机输入的朝向
/// degree 代表旋转度数（0/-360,+-90,+-180,+-270），负数代表附加镜像翻转
///	aspect 代表比例控制：0/1/-1 分别代表拉伸填充/截边保持比例（默认）/加边框保持比例
/// selelction 是机位选择（默认为当前机位）：0/1 代表后置/前置
-(void)orientation:(int)degree aspect:(int)aspect selection:(int)selection;

-(NSString*)getCurrentTimestamp;

@property(nonatomic, assign) double fps;
@property(nonatomic, retain) AVCaptureSession* session;
@end
