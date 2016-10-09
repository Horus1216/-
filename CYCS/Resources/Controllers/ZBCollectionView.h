//
//  ZBCollectionView.h
//  CYCS
//
//  Created by Horus on 16/8/23.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRefresh.h"
#import "YDFlowLayout.h"
@interface ZBCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YDFlowLayoutDelegate>

-(instancetype)initWithFrame:(CGRect)frame SceneID:(int)whichSceneID;

@end
