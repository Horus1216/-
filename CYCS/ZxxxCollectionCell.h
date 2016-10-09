//
//  ZxxxCollectionCell.h
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZxxxCollectionCell : UICollectionViewCell

@property(nonatomic,retain) NSArray *imageURL;
@property(nonatomic,retain) NSString *labelContext;
@property(nonatomic,retain) NSString *LabelImage;
@property(nonatomic,retain) NSString *wedHtml;
@property(nonatomic,retain) NSString *wedTime;

-(void)addSubviews;
-(void)setInfo;

@end
