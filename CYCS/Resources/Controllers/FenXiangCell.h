//
//  FenXiangCell.h
//  CYCS
//
//  Created by Horus on 16/8/25.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FenXiangCell : UITableViewCell

@property(nonatomic,retain) UIImageView *titleImageView;
@property(nonatomic,retain) UILabel *label;
@property(nonatomic,retain) NSString *imageName;
@property(nonatomic,retain) NSString *labelName;

-(void)setInfo;

@end
