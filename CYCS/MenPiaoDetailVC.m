//
//  MenPiaoDetailVC.m
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "MenPiaoDetailVC.h"

@implementation MenPiaoDetailVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=@"购票指南";
    self.navigationItem.titleView=labelTitle;
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, self.view.bounds.size.width-40, 60)];
    label.text=self.menpiaoDetail;
    label.textAlignment=NSTextAlignmentLeft;
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:13];
    label.frame=CGRectMake(20, 10, self.view.bounds.size.width-40, [self height:label]);
    [self.view addSubview:label];
}

-(CGFloat)height:(UILabel *)label
{
    NSDictionary *dic=@{NSFontAttributeName:label.font};
   CGSize size=[label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height;
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
