//
//  FenXiangCell.m
//  CYCS
//
//  Created by Horus on 16/8/25.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "FenXiangCell.h"

@implementation FenXiangCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews
{
    self.titleImageView=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.titleImageView];
    
    self.label=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.label];
}

-(void)setInfo
{
    self.titleImageView.frame=CGRectMake(5, 5, 20, 20);
    self.titleImageView.image=[UIImage imageNamed:self.imageName];
    self.label.frame=CGRectMake(self.titleImageView.frame.origin.x+self.titleImageView.frame.size.width+15, self.titleImageView.frame.origin.y, 180, 20);
    self.label.textColor=[UIColor whiteColor];
    self.label.text=self.labelName;
}


@end
