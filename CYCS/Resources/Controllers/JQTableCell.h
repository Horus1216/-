//
//  JQTableCell.h
//  CYCS
//
//  Created by Horus on 16/8/24.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQTableCell : UITableViewCell

@property(nonatomic,retain) NSDictionary *infoDic;
-(void)setViewInfo;

@end
