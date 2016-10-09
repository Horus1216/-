//
//  JiaoTongVC.m
//  CYCS
//
//  Created by Horus on 16/8/27.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "JiaoTongVC.h"
#import "JTNavigationVC.h"
#import "FWMainView.h"

@interface JiaoTongVC ()
{
    NSString *startLocation;
    NSString *endLocation;
    NSString *leadStyle;
}
@end

@implementation JiaoTongVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.segement addTarget:self action:@selector(segementAction:) forControlEvents:UIControlEventValueChanged];
    self.qishi.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.zhongdian.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.qishi.delegate=self;
    self.zhongdian.delegate=self;
    leadStyle=@"AMapSearchType_NaviDrive";
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=@"交通路线";
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
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [self.locationManager requestAlwaysAuthorization];
    }
    
#endif
    
}

-(void)rightItemAction
{
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

- (IBAction)buttonClicked:(id)sender {
    
    JTNavigationVC *vc=[[JTNavigationVC alloc]initWithBeginLocation:self.qishi.text EndLocation:self.zhongdian.text NavigationStyle:leadStyle];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)segementAction:(UISegmentedControl *)segement
{
    switch (segement.selectedSegmentIndex) {
        case 0:
            leadStyle=@"AMapSearchType_NaviDrive";
            break;
        case 1:
            leadStyle=@"AMapSearchType_NaviWalking";
            break;
        default:
            break;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.qishi resignFirstResponder];
    [self.zhongdian resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (textField==self.qishi) {
        self.qishi.text=@"";
    }
    else
    {
        self.zhongdian.text=@"";
    }
    return YES;
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [manager requestWhenInUseAuthorization];
            }
        }
            break;
            
        default:
            break;
    }
    
}
@end
