//
//  ZBCollectionCell.m
//  CYCS
//
//  Created by Horus on 16/8/23.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ZBCollectionCell.h"

@implementation ZBCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.titleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:self.titleLabel];
        
        self.imageView=[[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.imageView];

        self.contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:self.contentLabel];
    }
    return self;
}

-(void)setView
{
    self.titleLabel.frame=CGRectMake(0, 0, self.bounds.size.width-40, 40);
    self.titleLabel.font=[UIFont systemFontOfSize:15];
    self.titleLabel.numberOfLines=0;
    
    self.imageView.frame=CGRectMake(self.titleLabel.frame.origin.x+self.titleLabel.frame.size.width, 1, 40,40);
    
    self.contentLabel.frame=CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+5, self.frame.size.width, self.bounds.size.height-50);
    self.contentLabel.numberOfLines=0;
    self.contentLabel.font=[UIFont systemFontOfSize:12];
    
}

@end
