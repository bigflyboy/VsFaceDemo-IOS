//
//  ViewController.m
//  VsFaceDemo
//
//  Created by 王志远 on 2017/6/2.
//  Copyright © 2017年 王志远. All rights reserved.
//
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)UIButton* buttonOne;
@property (nonatomic, strong)UIButton* buttonTwo;
@property (nonatomic, strong)UIButton* buttonThree;
@property (nonatomic, strong)UIButton* buttonFour;
@property (nonatomic, strong)UIButton* buttonFive;
@property (nonatomic, strong)VsController* mVscontroller;
@property (nonatomic, strong)UIView* meiyanView;
@property (nonatomic, strong)UISlider* slider1;
@property (nonatomic, strong)UISlider* slider2;
@property (nonatomic, strong)UISlider* slider3;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _mVscontroller = [[VsController alloc]init];
    
    [_mVscontroller Init:self.view];
    
    isface = NO;
    isvideo = NO;
    isfair = NO;
    
    [_mVscontroller Display:YES];
    
    [self initView];
    
    [_mVscontroller Open];
    NSLog(@"VsController Open");
}

- (void)initView {
    
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenH-kScreenW/5, kScreenW/5, 80)];
    //[self.buttonOne addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];//点击事件
    [button1 setImage:[UIImage imageNamed:@"revert.png"] forState:(UIControlStateNormal)];//添加图片
    button1.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [button1 addTarget:self action:@selector(clickBtn1:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25]];
    [self.view addSubview:button1];
    
    
    UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW/5, kScreenH-kScreenW/5, kScreenW/5, 80)];
    //[self.buttonOne addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];//点击事件
    [button2 setImage:[UIImage imageNamed:@"picture.png"] forState:(UIControlStateNormal)];//添加图片
    button2.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [button2 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25]];
    [button2 addTarget:self action:@selector(clickBtn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    UIButton * button3 = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW/5*2, kScreenH-kScreenW/5, kScreenW/5, 80)];
    //[self.buttonOne addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];//点击事件
    [button3 setImage:[UIImage imageNamed:@"video_blue.png"] forState:(UIControlStateNormal)];//添加图片
    button3.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [button3 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25]];
    [button3 addTarget:self action:@selector(clickBtn3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    UIButton * button4 = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW/5*3, kScreenH-kScreenW/5, kScreenW/5, 80)];
    //[self.buttonOne addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];//点击事件
    [button4 setImage:[UIImage imageNamed:@"fair.png"] forState:(UIControlStateNormal)];//添加图片
    button4.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [button4 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25]];
    [button4 addTarget:self action:@selector(clickBtn4:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    
    UIButton * button5 = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW/5*4, kScreenH-kScreenW/5, kScreenW/5, 80)];
    //[self.buttonOne addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];//点击事件
    [button5 setImage:[UIImage imageNamed:@"face.png"] forState:(UIControlStateNormal)];//添加图片
    button5.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [button5 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25]];
    [button5 addTarget:self action:@selector(clickBtn5:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    _meiyanView = [[UIView alloc]init];//美颜试图
    
    UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenH-kScreenW/5-150, kScreenW/5, 50)];
    label1.text = @"美颜";
    label1.font = [UIFont systemFontOfSize:22];
    
    [_meiyanView addSubview:label1];
    UILabel* label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenH-kScreenW/5-100, kScreenW/5, 50)];
    label2.text = @"磨皮";
    label2.font = [UIFont systemFontOfSize:22];
    
    [_meiyanView addSubview:label2];
    UILabel* label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenH-kScreenW/5-50, kScreenW/5, 50)];
    label3.text = @"锐化";
    label3.font = [UIFont systemFontOfSize:22];
    
    [_meiyanView addSubview:label3];
    
    _slider1 = [[UISlider alloc]initWithFrame:CGRectMake(kScreenW/5, kScreenH-kScreenW/5-150, kScreenW/5*4, 50)];
    _slider1.minimumValue = 0;
    _slider1.maximumValue = 10;
    [_slider1 addTarget:self action:@selector(action1:) forControlEvents:UIControlEventValueChanged];
    _slider1.hidden = YES;
    [self.view addSubview:_slider1];
    
    _slider2 = [[UISlider alloc]initWithFrame:CGRectMake(kScreenW/5, kScreenH-kScreenW/5-100, kScreenW/5*4, 50)];
    _slider2.minimumValue = 0;
    _slider2.maximumValue = 10;
    [_slider2 addTarget:self action:@selector(action2:) forControlEvents:UIControlEventValueChanged];
    _slider2.hidden = YES;
    [self.view addSubview:_slider2];
    
    _slider3 = [[UISlider alloc]initWithFrame:CGRectMake(kScreenW/5, kScreenH-kScreenW/5-50, kScreenW/5*4, 50)];
    _slider3.minimumValue = 0;
    _slider3.maximumValue = 10;
    [_slider3 addTarget:self action:@selector(action3:) forControlEvents:UIControlEventValueChanged];
    _slider3.hidden = YES;
    [self.view addSubview:_slider3];
    
    _meiyanView.hidden = YES;
    
    [self.view addSubview:_meiyanView];
    
}

- (void)meiyan:(BOOL)ishide {
    _meiyanView.hidden = ishide;
    _slider1.hidden = ishide;
    _slider2.hidden = ishide;
    _slider3.hidden = ishide;
}

-(void)clickBtn1:(UIButton *)btn{
    //[self showMessage:@"切换摄像头"];
    
    [_mVscontroller Switch];
}

-(void)clickBtn2:(UIButton *)btn{
    //[self showMessage:@"截图"];
    [_mVscontroller Snapshot];
//    if (isopen) {
//        [_mVscontroller Open];
//    } else {
//        [_mVscontroller Close];
//    }
//    isopen = !isopen;
}

-(void)clickBtn3:(UIButton *)btn{
    //[self showMessage:@"录像"];
    if (isvideo) {
        [btn setImage:[UIImage imageNamed:@"video_blue.png"] forState:UIControlStateNormal];
        [_mVscontroller CaptureOff];
    } else {
        [btn setImage:[UIImage imageNamed:@"video_red.png"] forState:UIControlStateNormal];
        [_mVscontroller CaptureOn];
    }
    isvideo = !isvideo;
}

-(void)clickBtn4:(UIButton *)btn{
    //[self showMessage:@"美颜"];
    if(isfair){
        [btn setImage:[UIImage imageNamed:@"fair.png"] forState:UIControlStateNormal];
        [self meiyan:YES];
    } else {
        [btn setImage:[UIImage imageNamed:@"fair_red.png"] forState:UIControlStateNormal];
        [self meiyan:NO];
    }
    isfair = !isfair;
}

-(void)clickBtn5:(UIButton *)btn{
    //[self showMessage:@"人脸检测"];
    if(isface){
        [btn setImage:[UIImage imageNamed:@"face.png"] forState:UIControlStateNormal];
        [_mVscontroller FacerOff];
    } else {
        [btn setImage:[UIImage imageNamed:@"face_red.png"] forState:UIControlStateNormal];
        [_mVscontroller FacerOn];
    }
    isface = !isface;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)action1:(UISlider *)slide{
    float strenght =(float)slide.value/10;
    [_mVscontroller Brightening:strenght];
}

-(void)action2:(UISlider *)slide{
    float strenght =(float)slide.value/10;
    [_mVscontroller Smoothing:strenght];
}

-(void)action3:(UISlider *)slide{
    float strenght =(float)slide.value/10;
    [_mVscontroller Sharpening:strenght];
}


@end
