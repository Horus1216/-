//
//  JianjieVC.m
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "JianjieVC.h"

@interface JianjieVC ()
{
    NSString *jianjie;
}

@end

@implementation JianjieVC

-(instancetype)initWithString:(NSString *)string
{
    if (self=[super init]) {
        jianjie=string;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UITextView *content=[[UITextView alloc]initWithFrame:self.view.bounds];
    content.text=jianjie;
    content.font=[UIFont systemFontOfSize:13];
    content.editable=NO;
    [self.view addSubview:content];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=@"简介";
    self.navigationItem.titleView=labelTitle;
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
