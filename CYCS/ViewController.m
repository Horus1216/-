//
//  ViewController.m
//  CYCS
//
//  Created by Horus on 16/8/16.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"

#define ColorRGB(x, y, z, alp) [UIColor colorWithRed:(x)/255.0 green:(y)/255.0 blue:(z)/255.0 alpha:(alp)]
@interface ViewController ()
{
    BOOL isShowMoreList;
}
@property(nonatomic,retain) MainView *mianView;

@end

@implementation ViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"pushViewDetail" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushViewDetail:) name:@"pushViewDetail" object:nil];
    
    isShowMoreList=YES;
    self.view.backgroundColor=[UIColor lightGrayColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topBg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent=NO;
    UILabel *topTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    topTitle.text=@"首页";
    topTitle.textColor=[UIColor whiteColor];
    self.navigationItem.titleView=topTitle;
    
    UIButton *leftItemBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftItemBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    leftItemBtn.frame=CGRectMake(0, 0, 20, 20);
    [leftItemBtn addTarget:self action:@selector(leftItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftItemBtn];
    [self.navigationItem setLeftBarButtonItem:leftItem animated:YES];
    
    ListView *listView=[[ListView alloc]initWithFrame:CGRectMake(0, -64, self.view.bounds.size.width-80, self.view.bounds.size.height)];
    [self.view addSubview:listView];
    
    self.mianView=[[MainView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.mianView];
}

-(void)pushViewDetail:(NSNotification *)msg
{
    NSDictionary *dic=msg.userInfo;
    SceneDetailVC *sceneDetailVC=[[SceneDetailVC alloc]initWithDictionary:dic];
    [self.navigationController pushViewController:sceneDetailVC animated:YES];
}

-(void)leftItemClicked:(UIButton *)button
{
    if (isShowMoreList==YES) {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 0);
            self.mianView.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 0);

        }];

        isShowMoreList=NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.transform=CGAffineTransformMakeTranslation(0, 0);
        self.mianView.transform=CGAffineTransformMakeTranslation(0, 0);
        }];
        isShowMoreList=YES;
    }
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            LoginAndRegester *loginView=[[LoginAndRegester alloc]init];
            [self presentViewController:loginView animated:YES completion:^{
                
            }];
        });
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
