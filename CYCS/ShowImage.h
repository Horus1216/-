//
//  ShowImage.h
//  CYCS
//
//  Created by Horus on 16/8/20.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowImage : UIViewController<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate>

-(instancetype)initWithArray:(NSArray *)array Index:(int)index;

@end
