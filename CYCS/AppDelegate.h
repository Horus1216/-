//
//  AppDelegate.h
//  CYCS
//
//  Created by Horus on 16/8/16.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

