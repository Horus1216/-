//
//  FenXiangVC.m
//  CYCS
//
//  Created by Horus on 16/8/25.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "FenXiangVC.h"
#import "FenXiangCell.h"
#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "FWMainView.h"

@interface FenXiangVC()
{
    UIView *mainView;
    NSArray *imageName;
    NSArray *labelName;
}
@end

@implementation FenXiangVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.tencentOAuth=[[TencentOAuth alloc]initWithAppId:@"1105158435" andDelegate:self];
    
    mainView=[[UIView alloc]initWithFrame:CGRectZero];
    mainView.backgroundColor=[UIColor blackColor];
    mainView.layer.cornerRadius=8;
    [self.view addSubview:mainView];
    
    imageName=[NSArray arrayWithObjects:@"新浪微博",@"微信朋友圈",@"微信",@"邮件",@"login_third_qq_icon", nil];
    labelName=[NSArray arrayWithObjects:@"新浪微博",@"微信朋友圈",@"微信好友",@"好友邮箱",@"QQ好友分享",nil];
    
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=@"分享";
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

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
    FWMainView *mainView=[[[self.navigationController.viewControllers objectAtIndex:0].view subviews] objectAtIndex:1];
    [mainView viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        mainView.frame=CGRectMake(30, 30, self.view.frame.size.width-60, 240);
    } completion:^(BOOL finished) {
    
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 180, 30)];
        label.backgroundColor=[UIColor clearColor];
        label.text=@"分享到";
        label.textColor=[UIColor blueColor];
        [mainView addSubview:label];
        
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height+5, mainView.bounds.size.width, 2)];
        line.image=[UIImage imageNamed:@"topBg"];
        [mainView addSubview:line];
        
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, line.frame.origin.y+5, mainView.bounds.size.width, mainView.bounds.size.height-35)];
        tableView.backgroundColor=[UIColor clearColor];
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        tableView.delegate=self;
        tableView.dataSource=self;
        [mainView addSubview:tableView];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"myCell";
    FenXiangCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[FenXiangCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.imageName=[imageName objectAtIndex:indexPath.row];
        cell.labelName=[labelName objectAtIndex:indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    if (imageName&&labelName) {
        [cell setInfo];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            WBMessageObject *msg = [WBMessageObject message];
            msg.text = @"我正在使用畅游长沙Iphone客户端，第一手了解重庆各大美景，欢迎到苹果商店下载。";
            WBImageObject *image = [WBImageObject object];
            image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share@2x" ofType:@"png"]];
            msg.imageObject = image;
            [self messageToSina:msg];
        }
            break;
        case 1:
        {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"畅游长寿App分享";
            message.description = @"畅游长寿App分享";
            [message setThumbImage:[UIImage imageNamed:@"share"]];
            
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
            
            message.mediaObject = ext;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneTimeline;
            
            [WXApi sendReq:req];
        }
            break;
        case 2:
        {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"畅游长寿App分享";
            message.description = @"畅游长寿App分享";
            [message setThumbImage:[UIImage imageNamed:@"share"]];
            
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
            
            message.mediaObject = ext;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            
            [WXApi sendReq:req];
        }
            break;
            case 3:
        {
            Class mailClass = NSClassFromString(@"MFMailComposeViewController");
            if (mailClass != nil)
            {
                if ([mailClass canSendMail])
                {
                    [self displayMailComposerSheet];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"您的设备未设置邮件账户不能发送邮件"
                                                                   delegate:self
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"设置邮箱",nil];
                    [alert show];
                }
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"系统版本太低，不支持邮件功能"
                                                               delegate:nil
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
            break;
            case 4:
        {
            if ([self support]) {
                NSData *imgData = UIImagePNGRepresentation([UIImage imageNamed:@"share"]);
                QQApiImageObject *imgObj = [QQApiImageObject objectWithData:imgData
                                                           previewImageData:imgData
                                                                      title:@"畅游长寿App分享"
                                                               description :@"我正在使用畅游长沙Iphone客户端，第一手了解重庆各大美景，欢迎到苹果商店下载。"];
                SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
                QQApiSendResultCode sent = [QQApiInterface sendReq:req];
                if (sent == EQQAPISENDSUCESS) {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"分享成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                } else {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"分享失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                }
            }

        }
            break;
        default:
            break;
    }
}

- (void)messageToSina:(WBMessageObject*)object
{
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:object];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = YES;
    [WeiboSDK sendRequest:request];
}

- (BOOL)support {
    BOOL isSpupport = YES;
    if ([QQApiInterface isQQInstalled]) {
        if ([QQApiInterface isQQSupportApi]) {
            isSpupport = YES;
        } else {
            isSpupport = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"当前QQ版本太低，现在最新?" delegate:self cancelButtonTitle:@"不了" otherButtonTitles:@"现在更新", nil];
            [alert show];
        }
    } else {
        isSpupport = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"分享内容前必须安装QQ应用，是否安装?" delegate:self cancelButtonTitle:@"不了" otherButtonTitles:@"现在安装", nil];
        [alert show];
    }
    return isSpupport;
}

-(void)tencentDidLogin{
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
}

- (void)tencentDidNotNetWork {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"当前无网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1&&[alertView.title isEqualToString:@"友情提示"]) {
        NSString *qqAddress = [QQApiInterface getQQInstallUrl];
        NSLog(@"QQShareVC:%@", qqAddress);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:qqAddress]];
    }
    if (buttonIndex==1&&[alertView.title isEqualToString:@"提示"])
    {
        NSString *recipients = @"mailto:first@example.com";
        NSString *email = [recipients stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
    }
}

-(void)displayMailComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"畅游长寿App分享"];

    NSString *emailBody = @"我正在使用畅游长沙Iphone客户端，第一手了解重庆各大美景，欢迎到苹果商店下载。";
    [picker setMessageBody:emailBody isHTML:NO];

    NSData *myData = UIImagePNGRepresentation([UIImage imageNamed:@"share"]);
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"share@2x.png"];
    
    [self presentViewController:picker animated:YES completion:^{}];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            
            break;
        case MFMailComposeResultSaved:
            
            break;
        case MFMailComposeResultSent:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"邮件发送成功"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误！"
                                                            message:@"邮件发送失败，请稍后重试！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误！"
                                                            message:@"邮件发送失败，请稍后重试！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            
            break;
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
