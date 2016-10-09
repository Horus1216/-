//
//  SheZiVC.m
//  CYCS
//
//  Created by mac2015 on 16/8/27.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "SheZiVC.h"
#import "ListView.h"
#import "CSGKVC.h"
#import "LoginAndRegester.h"

@interface SheZiVC ()
{
    UITableView *AtableView;
    NSArray *arrayTitle;
    NSArray *arrayImage;
    BOOL isShowMoreList;
}
@end

@implementation SheZiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    isShowMoreList=YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topBg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent=NO;
    UILabel *topTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    topTitle.text=@"设置";
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
    
    arrayTitle=[NSArray arrayWithObjects:@"长寿概况",@"仅在wifi观看视频",@"清除缓存",@"关于我们",@"退出登陆", nil];
    arrayImage=[NSArray arrayWithObjects:@"more_button1",@"more_button2",@"more_button3",@"more_button5",@"", nil];
    AtableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    AtableView.delegate=self;
    AtableView.dataSource=self;
    [self.view addSubview:AtableView];
}
-(void)leftItemClicked:(UIButton *)button
{
    if (isShowMoreList==YES) {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 0);
            AtableView.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 0);
            
        }];
        
        isShowMoreList=NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.transform=CGAffineTransformMakeTranslation(0, 0);
            AtableView.transform=CGAffineTransformMakeTranslation(0, 0);
        }];
        isShowMoreList=YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayTitle count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"myCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (arrayTitle) {
        cell.imageView.image=[UIImage imageNamed:arrayImage[indexPath.row]];
        cell.textLabel.text=arrayTitle[indexPath.row];
    }
    switch (indexPath.row) {
        case 0:
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
        {
            UISwitch *shipin=[[UISwitch alloc]init];
            BOOL noDirectory=NO;
            NSFileManager *manager=[NSFileManager defaultManager];
            NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *wifiRequired=[NSString stringWithFormat:@"%@/wifiRequired.tag",library];
            if ([manager fileExistsAtPath:wifiRequired isDirectory:&noDirectory]) {
                shipin.on=YES;
            }
            else
            {
                shipin.on=NO;
            }
            [shipin addTarget:self action:@selector(swtichChange:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView=shipin;
        }
            break;
        case 2:
        {
            UILabel *huancun=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
            huancun.text=@"0.0K";
            huancun.textColor=[UIColor redColor];
            cell.accessoryView=huancun;
        }
            break;
        case 4:
        {
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)swtichChange:(UISwitch *)btn
{
    BOOL noDirectory=NO;
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *wifiNotRequired=[NSString stringWithFormat:@"%@/wifiNotRequired.tag",library];
    NSString *wifiRequired=[NSString stringWithFormat:@"%@/wifiRequired.tag",library];
    if (btn.on) {
        if ([manager fileExistsAtPath:wifiNotRequired isDirectory:&noDirectory]) {
            [manager removeItemAtPath:wifiNotRequired error:nil];
            [manager createFileAtPath:wifiRequired contents:nil attributes:nil];
        }
    }
    else
    {
        if ([manager fileExistsAtPath:wifiRequired isDirectory:&noDirectory]) {
            [manager removeItemAtPath:wifiRequired error:nil];
            [manager createFileAtPath:wifiNotRequired contents:nil attributes:nil];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NSString *urlString=@"http://112.74.108.147:6100/api/introduction";
            NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                if (data.length!=0) {
                   NSDictionary *savingData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    CSGKVC *vc=[[CSGKVC alloc]initWithDictionary:savingData];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            }];
        }
            break;
        case 4:
        {
            BOOL noDirectory=NO;
            NSFileManager *manager=[NSFileManager defaultManager];
            NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *OnceTag=[NSString stringWithFormat:@"%@/Once.tag",library];
            if (![manager fileExistsAtPath:OnceTag isDirectory:&noDirectory]) {
                [manager createFileAtPath:OnceTag contents:nil attributes:nil];
            }
            NSString *Loginned=[NSString stringWithFormat:@"%@/Loginned.tag",library];
            NSString *notLoginned=[NSString stringWithFormat:@"%@/notLoginned.tag",library];
            if ([manager fileExistsAtPath:Loginned isDirectory:&noDirectory]) {
                [manager removeItemAtPath:Loginned error:nil];
                [manager createFileAtPath:notLoginned contents:nil attributes:nil];
            }

     
                    LoginAndRegester *loginView=[[LoginAndRegester alloc]init];
                    [self presentViewController:loginView animated:YES completion:^{
                        
                    }];
  
        }
            break;
            
        default:
            break;
    }
}

@end
