//
//  ZBCollectionCell.h
//  CYCS
//
//  Created by Horus on 16/8/23.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBCollectionCell : UICollectionViewCell

@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) NSString *content;
@property(nonatomic,retain) UILabel *contentLabel;

-(void)setView;

@end
