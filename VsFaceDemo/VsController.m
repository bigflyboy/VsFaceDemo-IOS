//
//  VsController.m
//  VsFaceDemo
//
//  Created by 王志远 on 2017/6/6.
//  Copyright © 2017年 王志远. All rights reserved.
//

#import "VsController.h"

@interface VsController() {
    int a;
}
@property (nonatomic, strong)Gamera* m_gamera;

@end

@implementation VsController

-(void)Init:(UIView*) view{

    _m_gamera = [[Gamera alloc]init:view];
}//初始化

-(void)Display:(BOOL) enable{
    
}//开启、关闭预览

-(void)Open{
    //NSLog(@"VsController Open");
    //[_m_gamera setFps:5];
    [_m_gamera open:YES width:1280 height:720];
}//打开摄像头

-(void)Close{
    [_m_gamera close];
}//关闭摄像头

-(void)Switch{
    [_m_gamera switching];
}//切换摄像头


-(void)Snapshot{
    
}//截一张图

-(void)CaptureOn{
    
}//开始录像

-(void)CaptureOff{
    
}//停止录像

-(void)FacerOn{
    
}//开始人脸检测

-(void)FacerOff{
    
}//停止人脸检测

-(void)Brightening:(float) strength{
    
}//改变美白程度：0~1

-(void)Smoothing:(float) strength{
    
}// 改变磨皮程度：0~1

-(void)Sharpening:(float) strength{
    
}// 改变锐化程度：0~1

@end
