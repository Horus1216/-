//
//  ZBDetailVC.h
//  CYCS
//
//  Created by Horus on 16/8/23.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowImage.h"
#import "WeiZhiVC.h"
#import "JianjieVC.h"

@interface ZBDetailVC : UIViewController<UIScrollViewDelegate,UIActionSheetDelegate>

-(instancetype)initWithDictionary:(NSDictionary *)info;

@end
