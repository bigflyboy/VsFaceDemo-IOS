//
//  Gamera.m
//  VsFaceDemo
//
//  Created by 王志远 on 2017/6/7.
//  Copyright © 2017年 王志远. All rights reserved.
//

#import "Gamera.h"

//w

///////////////////////////////////////////////////////////
@interface Gamera() {
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



@implementation Gamera
///////////////////////////////////////////////////////////
///	@synthesize camera = camera;
- (void)dealloc {
    [self close];
    ///	ARC forbids explicit message send of 'release'; since iOS 6 even for dispatch_release() calls: stripping it out in that case is required.
#if !OS_OBJECT_USE_OBJC
    if(frameRenderingSemaphore != NULL)
        dispatch_release(frameRenderingSemaphore);
#endif
}
-(id)init:(UIView*)preview {
    self = [super init];
    view = preview;
    cameraProcessingQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0);
    _session = nil;
    _device  = nil;
    _input   = nil;
    _output  = nil;
    selection = -1;
    preset = nil;
    return self;
}
-(void*)gpuMode:(NSString*)mode {
    ///	TO DO
    return nil;
}
-(int)open:(BOOL)front width:(int)w height:(int)h {
    AVCaptureDevicePosition positions[2] = {AVCaptureDevicePositionBack, AVCaptureDevicePositionFront};
    selection = front ? 1 : 0;
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for(AVCaptureDevice *device in devices) {
        if([device position] == positions[selection]) {
            _device = device;
            break;
        }
    }
    if(!_device)
        return selection = -1;
    if(!_session)
        _session = [[AVCaptureSession alloc] init];
    [_session beginConfiguration];
    NSError *error = nil;
    _input = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:&error];
    if([_session canAddInput:_input])
        [_session addInput:_input];
    
    _output = [[AVCaptureVideoDataOutput alloc] init];
    [_output setAlwaysDiscardsLateVideoFrames:NO];
    [_output setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    [_output setSampleBufferDelegate:self queue:cameraProcessingQueue];
    if([_session canAddOutput:_output])
        [_session addOutput:_output];
    else {
        NSLog(@"Couldn't add video output");
        return -1;
    }
    int s = w*h;
    preset =
    (s == 1280*720) ? AVCaptureSessionPreset1280x720 :
    (s ==  640*480) ? AVCaptureSessionPreset640x480 :
    (s >   640*480) ? AVCaptureSessionPresetHigh :
    (s >   320*240) ? AVCaptureSessionPresetMedium
    : AVCaptureSessionPresetLow;
    width = w;
    height = h;
    [_session setSessionPreset:preset];
    [_session commitConfiguration];
    [_session startRunning];
    return selection;
}
-(int)switching {
    if(selection < 0)
        return -1;
    [self close];
    return [self open:!!selection width:width height:height];
}
-(int)close {
    if(selection < 0)
        return -1;
    selection = -1;
    [_output setSampleBufferDelegate:nil queue:dispatch_get_main_queue()];
    [_session stopRunning];
    [_session beginConfiguration];
    [_session removeInput:_input];
    [_session removeOutput:_output];
    [_session commitConfiguration];
    _device  = nil;
    _input   = nil;
    _output  = nil;
    return -1;
}
-(int)active {
    return selection;
}
-(void)orientation:(int)degree aspect:(int)aspect selection:(int)selection {
    ///	TO DO
}
- (void)setFps:(double)fps; {
    _fps = fps;
    int32_t rate = (int)fps;
    NSError *error;
    if(rate > 0) {
        if([_device respondsToSelector:@selector(setActiveVideoMinFrameDuration:)]
           &&[_device respondsToSelector:@selector(setActiveVideoMaxFrameDuration:)]) {
            [_device lockForConfiguration:&error];
            if(error == nil) {
#if defined(__IPHONE_7_0)
                [_device setActiveVideoMinFrameDuration:CMTimeMake(1, rate)];
                [_device setActiveVideoMaxFrameDuration:CMTimeMake(1, rate)];
#endif
            }
            [_device unlockForConfiguration];
        } else {
            for(AVCaptureConnection *connection in _output.connections) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                if([connection respondsToSelector:@selector(setVideoMinFrameDuration:)])
                    connection.videoMinFrameDuration = CMTimeMake(1, rate);
                if ([connection respondsToSelector:@selector(setVideoMaxFrameDuration:)])
                    connection.videoMaxFrameDuration = CMTimeMake(1, rate);
#pragma clang diagnostic pop
            }
        }
    }
    else {
        if([_device respondsToSelector:@selector(setActiveVideoMinFrameDuration:)]
           &&[_device respondsToSelector:@selector(setActiveVideoMaxFrameDuration:)]) {
            [_device lockForConfiguration:&error];
            if(error == nil) {
#if defined(__IPHONE_7_0)
                [_device setActiveVideoMinFrameDuration:kCMTimeInvalid];
                [_device setActiveVideoMaxFrameDuration:kCMTimeInvalid];
#endif
            }
            [_device unlockForConfiguration];
        } else {
            for(AVCaptureConnection *connection in _output.connections) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                if ([connection respondsToSelector:@selector(setVideoMinFrameDuration:)])
                    connection.videoMinFrameDuration = kCMTimeInvalid;	///	sets videoMinFrameDuration back to default
                if ([connection respondsToSelector:@selector(setVideoMaxFrameDuration:)])
                    connection.videoMaxFrameDuration = kCMTimeInvalid;	///	sets videoMaxFrameDuration back to default
#pragma clang diagnostic pop
            }
        }
    }
}
//- (AVCaptureConnection *)videoCaptureConnection {
//	for(AVCaptureConnection *connection in [_output connections])
//		for( AVCaptureInputPort *port in [connection inputPorts])
//			if([[port mediaType] isEqual:AVMediaTypeVideo] )
//				return connection;
//	return nil;
//}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    if([self active] < 0) {
        NSLog(@"!!! [Gamera captureOutput] not active!");
        return;
    }
    if(captureOutput != _output) {
        NSLog(@"!!! [Gamera captureOutput] mismatch!");
        return;
    }
    if(self.sampleDelegate)
        [self.sampleDelegate preVideoSampleBuffer: sampleBuffer];
    
    CVImageBufferRef cameraFrame = CMSampleBufferGetImageBuffer(sampleBuffer);
    int	w = (int)CVPixelBufferGetWidth(cameraFrame),
    h = (int)CVPixelBufferGetHeight(cameraFrame);
    CVPixelBufferLockBaseAddress(cameraFrame, 0);
    unsigned char *p = (unsigned char*)CVPixelBufferGetBaseAddress(cameraFrame);
    CVPixelBufferUnlockBaseAddress(cameraFrame, 0);
    
    static int sn = 0;
    NSLog(@"[Gamera captureOutput] %dx%d [%02X...] #%d", w, h, p[0], sn ++);
    //    NSString* time = [self getCurrentTimestamp];
    //    NSLog(@"%@", time);
}

-(NSString*)getCurrentTimestamp{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
    
}
///////////////////////////////////////////////////////////
@end
