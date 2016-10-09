//
//  ZxxxVCDetail.m
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ZxxxVCDetail.h"

@implementation ZxxxVCDetail

-(instancetype)initWthString:(NSArray *)infoArray
{
    if (self=[super init]) {
        self.webArray=infoArray;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=@"咨询详情";
    self.navigationItem.titleView=labelTitle;
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    
    UILabel *labelContext=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    labelContext.font=[UIFont systemFontOfSize:13];
    labelContext.text=self.webArray[1];
    labelContext.textColor=[UIColor greenColor];
    [self.view addSubview:labelContext];
    
    UILabel *labelTime=[[UILabel alloc]initWithFrame:CGRectMake(0, labelContext.frame.origin.y+labelContext.frame.size.height, 200, 15)];
    labelTime.text=self.webArray[2];
    labelTime.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:labelTime];
    
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, labelTime.frame.origin.y+labelTime.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-labelContext.frame.origin.y-labelContext.frame.size.height-64)];
    webView.backgroundColor=[UIColor clearColor];
    [webView loadHTMLString:self.webArray[0] baseURL:nil];
    [self.view addSubview:webView];
    
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
