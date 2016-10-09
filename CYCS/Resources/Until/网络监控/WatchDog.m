//
//  WatchDog.m
//  UseNetWork
//
//  Created by qianzhenlei on 12-3-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "WatchDog.h"
#import "Reachability.h"

static WatchDog *g_instance = nil;

@interface WatchDog ()
@property (strong,nonatomic) Reachability * hostReach;
@end

@implementation WatchDog

//创建监视狗单例
+ (WatchDog*)luckDog
{
    @synchronized(self){//@synchronized是同步的意思，目的是防止多个线程同时访问
        if (nil == g_instance){
            g_instance = [[WatchDog alloc] init];
        }
    }
    return g_instance;
}

//返回当前网络状态
- (NSString*)networkStatus:(Reachability*)curReach {
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    NSString * tips = @"";
    switch (status)
    {
        case NotReachable:
            tips = @"no network";
            break;
            
        case ReachableViaWiFi:
            tips = @"wifi";
            break;
            
        case kReachableVia2G:
            tips = @"2G";
            break;
            
        case kReachableVia3G:
            tips = @"3G";
            break;
            
        case kReachableVia4G:
            tips = @"4G";
            break;
    }
    
    NSLog(@"WatchDog: %@",tips);
    return tips;
}

//获取当前网络状态(2G/3G/3G/wifi)
- (NSString*)currentNetwork {
    self.hostReach = [Reachability reachabilityWithHostName:@"https://www.baidu.com"];
    return [self networkStatus:self.hostReach];
}

@end
