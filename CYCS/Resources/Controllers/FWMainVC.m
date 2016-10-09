//
//  FWMainVC.m
//  CYCS
//
//  Created by Horus on 16/8/24.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "FWMainVC.h"
#import "ListView.h"
#import "DZDHVC.h"
#import "FenXiangVC.h"
#import "JiaoTongVC.h"
#import "JianYiVC.h"

@interface FWMainVC ()
{
    FWMainView *fwMainView;
    BOOL isShowMoreList;
}
@end

@implementation FWMainVC

-(void)viewDidLoad
{
    isShowMoreList=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topBg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent=NO;
    UILabel *topTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    topTitle.text=@"精选服务";
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
    
    fwMainView=[[FWMainView alloc]initWithFrame:self.view.bounds];
    fwMainView.delegate=self;
    [self.view addSubview:fwMainView];
}

-(void)leftItemClicked:(UIButton *)button
{
    if (isShowMoreList==YES) {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 0);
            fwMainView.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 0);
            
        }];
        
        isShowMoreList=NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.transform=CGAffineTransformMakeTranslation(0, 0);
            fwMainView.transform=CGAffineTransformMakeTranslation(0, 0);
        }];
        isShowMoreList=YES;
    }
}

-(void)FWMainViewPush:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            JQZXVC *vc=[[JQZXVC alloc]init];
            [UIView transitionWithView:self.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                [self.navigationController pushViewController:vc animated:NO];
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case 1:
        {
            DZDHVC *vc=[[DZDHVC alloc]init];
            [UIView transitionWithView:self.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                [self.navigationController pushViewController:vc animated:NO];
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case 2:
        {
            FenXiangVC *vc=[[FenXiangVC alloc]init];
            [UIView transitionWithView:self.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                [self.navigationController pushViewController:vc animated:NO];
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case 3:
        {
            UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            JiaoTongVC *vc=[board instantiateViewControllerWithIdentifier:@"JiaoTong"];
            [UIView transitionWithView:self.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                [self.navigationController pushViewController:vc animated:NO];
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case 4:
        {
            UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            JianYiVC *vc=[board instantiateViewControllerWithIdentifier:@"JianYiVC"];
            [UIView transitionWithView:self.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                [self.navigationController pushViewController:vc animated:NO];
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        default:
            break;
    }
}

@end
