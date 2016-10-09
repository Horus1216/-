//
//  JQZXVC.m
//  CYCS
//
//  Created by Horus on 16/8/24.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "JQZXVC.h"
#import "JQTableCell.h"
#import "FWMainView.h"

@interface JQZXVC ()
{
    UITableView *AtableView;
    NSArray *savingData;
    UIWebView *webTel;
}

@end

@implementation JQZXVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *urlString=@"http://112.74.108.147:6100/api/zixunList";
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data.length!=0) {
            savingData=[[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"a"];
            [self addTableView];
        }
        
    }];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=@"景区咨询";
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

}

-(void)rightItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
    FWMainView *mainView=[[[self.navigationController.viewControllers objectAtIndex:0].view subviews] objectAtIndex:1];
    [mainView viewDidLoad];
}

-(void)addTableView
{
    AtableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    AtableView.delegate=self;
    AtableView.dataSource=self;
    AtableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:AtableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [savingData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"myCell";
    JQTableCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[JQTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (savingData) {
        cell.infoDic=[savingData objectAtIndex:indexPath.row];
    }
    [cell setViewInfo];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    webTel = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSDictionary *dic=[savingData objectAtIndex:indexPath.row];
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[dic objectForKey:@"d"]]];
    [webTel loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
    FWMainView *mainView=[[[self.navigationController.viewControllers objectAtIndex:0].view subviews] objectAtIndex:1];
    [mainView viewDidLoad];
}

@end
