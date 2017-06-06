//
//  VsController.h
//  VsFaceDemo
//
//  Created by 王志远 on 2017/6/6.
//  Copyright © 2017年 王志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VsController : NSObject

-(void)Init;//初始化

-(void)Display:(BOOL) enable;//开启、关闭预览

-(void)Open;//打开摄像头

-(void)Close;//关闭摄像头

-(void)Switch;//切换摄像头

-(void)Snapshot;//截一张图

-(void)CaptureOn;//开始录像

-(void)CaptureOff;//停止录像

-(void)FacerOn;//开始人脸检测

-(void)FacerOff;//停止人脸检测

-(void)Brightening:(float) strength;//改变美白程度：0~1

-(void)Smoothing:(float) strength;// 改变磨皮程度：0~1

-(void)Sharpening:(float) strength;// 改变锐化程度：0~1

@end
