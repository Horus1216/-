//
//  AppDelegate.m
//  CYCS
//
//  Created by Horus on 16/8/16.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "AppDelegate.h"
#define KAppKey @"3675698324"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [WeiboSDK registerApp:KAppKey];
    [WXApi registerApp:@"wx2b1d23c7656d3e04"];
    
    BOOL noDirectory=NO;
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *wifiRequired=[NSString stringWithFormat:@"%@/wifiRequired.tag",library];
    NSString *wifiNotRequired=[NSString stringWithFormat:@"%@/wifiNotRequired.tag",library];
    if (![manager fileExistsAtPath:wifiRequired isDirectory:&noDirectory]&&![manager fileExistsAtPath:wifiNotRequired isDirectory:&noDirectory]) {
        [manager createFileAtPath:wifiRequired contents:nil attributes:nil];
    }
    NSString *AutoLogingRequired=[NSString stringWithFormat:@"%@/AutoLogingRequired.tag",library];
    NSString *AutoLogingNotRequired=[NSString stringWithFormat:@"%@/AutoLogingNotRequired.tag",library];
    if (![manager fileExistsAtPath:AutoLogingRequired isDirectory:&noDirectory]&&![manager fileExistsAtPath:AutoLogingNotRequired isDirectory:&noDirectory]) {
        [manager createFileAtPath:AutoLogingRequired contents:nil attributes:nil];
    }
    NSString *Loginned=[NSString stringWithFormat:@"%@/Loginned.tag",library];
    NSString *notLoginned=[NSString stringWithFormat:@"%@/notLoginned.tag",library];
    if (![manager fileExistsAtPath:Loginned isDirectory:&noDirectory]&&![manager fileExistsAtPath:notLoginned isDirectory:&noDirectory]) {
        [manager createFileAtPath:notLoginned contents:nil attributes:nil];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 重载application方法来响应新浪微博方法的回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //url的内容：wb828961957://response?id=245D9074-CD2D-4C78-8399-ABE2258D946E&sdkversion=2.5
    return [WeiboSDK handleOpenURL:url delegate:self];
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
    return  [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    // ...
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"成功了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else if (response.statusCode == WeiboSDKResponseStatusCodeUserCancel){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"取消了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"失败了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    NSDictionary *dic = response.userInfo;
    if (dic && [dic count]) {
        NSString *access_token = [dic objectForKey:@"access_token"];
        NSInteger expires_in = [[dic objectForKey:@"expires_in"] integerValue];
        NSString *uid = [dic objectForKey:@"expires_in"];
        
        NSLog(@"\naccess_token:%@\nuid:%@\nexpires_in:%d", access_token, uid, (int)expires_in);
        
        [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"sinaToken"];
        [[NSUserDefaults standardUserDefaults] setInteger:expires_in forKey:@"sinaExpires"];
        [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"sinaUid"];

        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        [[NSUserDefaults standardUserDefaults] setFloat:interval forKey:@"sinaSaveTimer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"微信分享结果"];
        NSString *strMsg = @"哦, 分享失败了";
        if (resp.errCode == 0)
        {
            strMsg = @"分享成功";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                        message:strMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
