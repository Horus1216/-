//
//  JianYiVC.m
//  CYCS
//
//  Created by Horus on 16/8/28.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "JianYiVC.h"
#import "LoginAndRegester.h"
#import "FWMainView.h"

@implementation JianYiVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=@"投诉建议";
    self.navigationItem.titleView=labelTitle;
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
    UIButton *rightItem=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setBackgroundImage:[UIImage imageNamed:@"tongyong_send-button"] forState:UIControlStateNormal];
    rightItem.frame=CGRectMake(0, 0, 25, 25);
    [rightItem addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightItem=[[UIBarButtonItem alloc]initWithCustomView:rightItem];
    [self.navigationItem setRightBarButtonItem:barRightItem];
    
    
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
    FWMainView *mainView=[[[self.navigationController.viewControllers objectAtIndex:0].view subviews] objectAtIndex:1];
    [mainView viewDidLoad];
}

-(void)rightItemAction
{
    [self.name resignFirstResponder];
    [self.telephone resignFirstResponder];
    [self.content resignFirstResponder];
    
    NSString *urlString=@"http://112.74.108.147:6100/api/complaint";
    NSString *getSceneJson=[NSString stringWithFormat:@"p={\"a\":\"%@\",\"b\":\"%@\",\"c\":\"%@\"}",self.name.text,self.telephone.text,self.content.text];
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[getSceneJson dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data.length!=0) {
            NSDictionary *savingData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *succ=[savingData objectForKey:@"z"];
            if ([[succ objectForKey:@"a"]isEqualToString:@"200"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"投诉成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [self backItemAction];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"投诉失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        }
        
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    BOOL noDirectory=NO;
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *Loginned=[NSString stringWithFormat:@"%@/Loginned.tag",library];
    if ([manager fileExistsAtPath:Loginned isDirectory:&noDirectory]) {
        return;
    }
    else
    {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                LoginAndRegester *loginView=[[LoginAndRegester alloc]init];
                [self presentViewController:loginView animated:YES completion:^{
                    
                }];
            });
        });
    }
}

@end
