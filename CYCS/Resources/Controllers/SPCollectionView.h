//
//  SPCollectionView.h
//  CYCS
//
//  Created by Horus on 16/8/22.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRefresh.h"

@interface SPCollectionView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


-(instancetype)initWithFrame:(CGRect)frame SceneID:(int)whichSceneID;

@end
