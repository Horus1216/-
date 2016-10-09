//
//  FenXiangVC.h
//  CYCS
//
//  Created by Horus on 16/8/25.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface FenXiangVC : UIViewController<UITableViewDelegate,UITableViewDataSource,TencentSessionDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@end
