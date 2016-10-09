//
//  CollectionViewCell.m
//  CYCS
//
//  Created by Horus on 16/8/19.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.bounds.size.height-10,self.bounds.size.height-10)];
        [self addSubview:self.imageView];
        
        self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.imageView.frame.origin.x+self.imageView.frame.size.width+5, self.imageView.frame.origin.y+5, self.bounds.size.width-self.imageView.frame.size.width-5, 15)];
        self.titleLabel.font=[UIFont systemFontOfSize:15];
        [self addSubview:self.titleLabel];
        
        self.contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y+20, self.titleLabel.frame.size.width, 40)];
        self.contentLabel.numberOfLines=2;
        self.contentLabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:self.contentLabel];
    }
    return self;
}

@end
