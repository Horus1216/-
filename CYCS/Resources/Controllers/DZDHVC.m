//
//  DZDHVC.m
//  CYCS
//
//  Created by Horus on 16/8/25.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "DZDHVC.h"
#import "WeiZhiVC.h"
#import "FWMainView.h"

@interface DZDHVC()
{
    int _num;
    BOOL _isUP;
}
@end

@implementation DZDHVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=@"电子导游";
    self.navigationItem.titleView=labelTitle;
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
    UIButton *rightItem=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setBackgroundImage:[UIImage imageNamed:@"jingxuanfuwu"] forState:UIControlStateNormal];
    rightItem.frame=CGRectMake(0, 0, 25, 25);
    [rightItem addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightItem=[[UIBarButtonItem alloc]initWithCustomView:rightItem];
    [self.navigationItem setRightBarButtonItem:barRightItem];
    
    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 260, 2)];
    _line.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:_line];
    
    _num = 0;
    _isUP = NO;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                  target:self
                                                selector:@selector(animation)
                                                userInfo:nil
                                                 repeats:YES];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10,imageView.frame.origin.y+imageView.frame.size.height+10,imageView.frame.size.width , 60)];
    lab.backgroundColor = [UIColor clearColor];
    lab.numberOfLines = 2;
    lab.textColor = [UIColor whiteColor];
    lab.text = @"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [self.view addSubview:lab];
}

-(void)rightItemAction
{
    [self.timer invalidate];
    self.timer=nil;
    [self.navigationController popViewControllerAnimated:YES];
    FWMainView *mainView=[[[self.navigationController.viewControllers objectAtIndex:0].view subviews] objectAtIndex:1];
    [mainView viewDidLoad];
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
    FWMainView *mainView=[[[self.navigationController.viewControllers objectAtIndex:0].view subviews] objectAtIndex:1];
    [mainView viewDidLoad];
}

- (void)animation
{
    if (_isUP == NO)
    {
        _num++;
        int tmpY = _num*2;
        self.line.frame = CGRectMake(30, 20+tmpY, 260, 2);
        if (tmpY == 280)
        {
            _isUP = YES;
        }
    }
    else
    {
        _num--;
        int tmpY = _num*2;
        self.line.frame = CGRectMake(30, 20+tmpY, 260, 2);
        if (_num == 0)
        {
            _isUP = NO;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self beginScan];
}

- (void)beginScan
{
    self.device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.input=[AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.output=[[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session=[[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    self.output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode];
    
    self.preview=[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity=AVLayerVideoGravityResizeAspectFill;
    self.preview.frame =CGRectMake(20,20,280,280);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    [self.session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [self.session stopRunning];
    [self.timer invalidate];
    self.timer=nil;
    NSString *stringValue = nil;
    if ([metadataObjects count]!=0) {
        AVMetadataMachineReadableCodeObject *metadataObject=[metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    NSArray *array=[stringValue componentsSeparatedByString:@","];
    WeiZhiVC *vc=[[WeiZhiVC alloc]initWithArray:@[array[0],array[1]] title:array[2]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
