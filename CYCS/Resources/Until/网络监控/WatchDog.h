//
//  WatchDog.h
//  UseNetWork
//
//  Created by qianzhenlei on 12-3-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatchDog : NSObject

//创建监视狗单例
+ (WatchDog*)luckDog;

//获取当前网络状态(2G/3G/4G/wifi)
- (NSString*)currentNetwork;

@end
