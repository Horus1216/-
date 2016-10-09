//
//  JQTableCell.m
//  CYCS
//
//  Created by Horus on 16/8/24.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "JQTableCell.h"

@interface JQTableCell ()

@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) UIImageView *telImage;
@property(nonatomic,retain) UILabel *phomeNum;
@property(nonatomic,retain) UIImageView *line;

@end

@implementation JQTableCell

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
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.titleLabel];
    
    self.telImage=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.telImage];
    
    self.phomeNum=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.phomeNum];
    
    self.line=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.line];
    
}

-(void)setViewInfo
{
    self.titleLabel.frame=CGRectMake(20, 10, 200, 20);
    self.titleLabel.text=[self.infoDic objectForKey:@"c"];
    self.titleLabel.textColor=[UIColor greenColor];
    
    self.telImage.frame=CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+5, 12, 12);
    self.telImage.image=[UIImage imageNamed:@"nearby_service_phone"];
    
    self.phomeNum.frame=CGRectMake(self.telImage.frame.origin.x+self.telImage.frame.size.width+5, self.telImage.frame.origin.y, 200, 12);
    self.phomeNum.text=[self.infoDic objectForKey:@"d"];
    self.phomeNum.font=[UIFont systemFontOfSize:12];
    
    self.line.frame=CGRectMake(self.titleLabel.frame.origin.x, self.phomeNum.frame.origin.y+self.phomeNum.frame.size.height+5, 260, 2);
    self.line.image=[UIImage imageNamed:@"nearby_detail_line"];
}

@end
