//
//  CSGKVC.h
//  CYCS
//
//  Created by mac2015 on 16/8/27.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowImage.h"

@interface CSGKVC : UIViewController<UIScrollViewDelegate,UIActionSheetDelegate>

-(instancetype)initWithDictionary:(NSDictionary *)info;

@end
