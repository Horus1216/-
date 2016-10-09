//
//  ListView.m
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ListView.h"
#import "ViewController.h"
#import "ZxxxVC.h"
#import "ShiPinVC.h"
#import "ZhouBianVC.h"
#import "FWMainVC.h"
#import "SheZiVC.h"

@interface ListView ()
{
    NSArray *listTitle;
}
@end

@implementation ListView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
        [self listView];
    }
    return self;
}

-(void)listView
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.bounds.size.width, 100)];
    imageView.image=[UIImage imageNamed:@"cqyou"];
    [self addSubview:imageView];
    
    UITableView *tableList=[[UITableView alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height, self.bounds.size.width, self.bounds.size.height-120) style:UITableViewStylePlain];
    tableList.delegate=self;
    tableList.dataSource=self;
    tableList.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableList.backgroundColor=[UIColor clearColor];
    [self addSubview:tableList];
    
    listTitle=[NSArray arrayWithObjects:@"首页",@"最新消息",@"视频动态",@"周边配套",@"精选服务",@"设置", nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listTitle count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"myCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor=[UIColor clearColor];
    }
    if (listTitle&&indexPath.row<[listTitle count]) {
        cell.textLabel.text=[listTitle objectAtIndex:indexPath.row];
        cell.textLabel.textColor=[UIColor whiteColor];
        switch (indexPath.row) {
            case 0:
                cell.imageView.image=[UIImage imageNamed:@"home"];
                break;
            case 1:
                cell.imageView.image=[UIImage imageNamed:@"zuixin"];
                break;
            case 2:
                cell.imageView.image=[UIImage imageNamed:@"shipingdongtai"];
                break;
            case 3:
                cell.imageView.image=[UIImage imageNamed:@"zhoubianpeitao"];
                break;
            case 4:
                cell.imageView.image=[UIImage imageNamed:@"jingxuanfuwu"];
                break;
            case 5:
                cell.imageView.image=[UIImage imageNamed:@"more-setting"];
                break;
            default:
                break;
        }
        cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"topBg"]];
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        CGSize itemSize = CGSizeMake(15, 15);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            UINavigationController *nvg=[[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
            [UIApplication sharedApplication].keyWindow.rootViewController=nvg;
        }
            break;
        case 1:
        {
            UINavigationController *nvg=[[UINavigationController alloc]initWithRootViewController:[[ZxxxVC alloc]init]];
            [UIApplication sharedApplication].keyWindow.rootViewController=nvg;
        }
            break;
        case 2:
        {
            UINavigationController *nvg=[[UINavigationController alloc]initWithRootViewController:[[ShiPinVC alloc]init]];
            [UIApplication sharedApplication].keyWindow.rootViewController=nvg;
        }
            break;
        case 3:
        {
            UINavigationController *nvg=[[UINavigationController alloc]initWithRootViewController:[[ZhouBianVC alloc]init]];
            [UIApplication sharedApplication].keyWindow.rootViewController=nvg;
        }
            break;
        case 4:
        {
            UINavigationController *nvg=[[UINavigationController alloc]initWithRootViewController:[[FWMainVC alloc]init]];
            [UIApplication sharedApplication].keyWindow.rootViewController=nvg;
        }
            break;
        case 5:
        {
            UINavigationController *nvg=[[UINavigationController alloc]initWithRootViewController:[[SheZiVC alloc]init]];
            [UIApplication sharedApplication].keyWindow.rootViewController=nvg;
        }
            break;
        default:
            break;
    }
}

@end
