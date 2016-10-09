//
//  CollectionView.h
//  CYCS
//
//  Created by Horus on 16/8/19.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "SDRefresh.h"

@interface CollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

-(instancetype)initWithFrame:(CGRect)frame SceneID:(int)whichSceneID;


@end
