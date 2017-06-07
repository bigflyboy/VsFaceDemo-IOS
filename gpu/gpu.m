//
//  gpu.m
//  VsFaceDemo
//
//  Created by 王志远 on 2017/6/7.
//  Copyright © 2017年 王志远. All rights reserved.
//

#import "gpu.h"

///////////////////////////////////////////////////////////
@interface gpu() {
    UIView *view;
    dispatch_queue_t cameraProcessingQueue;
    int width, height, selection;
    NSString *preset;
}
@property(nonatomic, retain) AVCaptureDevice* device;
@property(nonatomic, retain) AVCaptureDeviceInput* input;
@property(nonatomic, retain) AVCaptureVideoDataOutput* output;
@property(nonatomic, assign) CMSampleBufferRef sampleBuffer;
///////////////////////////////////////////////////////////
@end

@implementation gpu

-(id)init:(UIView*)preview{
    self = [super init];
    view = preview;
    cameraProcessingQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
//    _session = nil;
    _device  = nil;
    _input   = nil;
    _output  = nil;
    selection = -1;
    preset = nil;
    return self;
}

-(void)helloA{
    NSLog(@"helloA......");
}

@end
