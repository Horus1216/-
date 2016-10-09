//
//  ZhouBianVC.m
//  CYCS
//
//  Created by Horus on 16/8/23.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ZhouBianVC.h"
#import "ListView.h"
#import "ZBMainView.h"
#import "ZBDetailVC.h"

@interface ZhouBianVC ()
{
    ZBMainView *zbMainView;
    BOOL isShowMoreList;
}
@end

@implementation ZhouBianVC

-(void)viewDidLoad
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushViewDetail:) name:@"pushViewZBDetail" object:nil];
    
    isShowMoreList=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topBg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent=NO;
    UILabel *topTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    topTitle.text=@"周边配套";
    topTitle.textColor=[UIColor whiteColor];
    self.navigationItem.titleView=topTitle;
    
    ListView *listView=[[ListView alloc]initWithFrame:CGRectMake(0, -64, self.view.bounds.size.width-80, self.view.bounds.size.height)];
    [self.view addSubview:listView];
    
    UIButton *leftItemBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftItemBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    leftItemBtn.frame=CGRectMake(0, 0, 20, 20);
    [leftItemBtn addTarget:self action:@selector(leftItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftItemBtn];
    [self.navigationItem setLeftBarButtonItem:leftItem animated:YES];
    
    zbMainView=[[ZBMainView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:zbMainView];
}

-(void)leftItemClicked:(UIButton *)button
{
    if (isShowMoreList==YES) {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 0);
            zbMainView.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 0);
            
        }];
        
        isShowMoreList=NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.transform=CGAffineTransformMakeTranslation(0, 0);
            zbMainView.transform=CGAffineTransformMakeTranslation(0, 0);
        }];
        isShowMoreList=YES;
    }
}

-(void)pushViewDetail:(NSNotification *)msg
{
    NSDictionary *dic=msg.userInfo;
    ZBDetailVC *sceneDetailVC=[[ZBDetailVC alloc]initWithDictionary:dic];
    [self.navigationController pushViewController:sceneDetailVC animated:YES];
}

@end
