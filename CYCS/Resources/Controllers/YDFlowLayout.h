//
//  YDFlowLayout.h
//  YDCollectionView
//
//  Created by Mr Qian on 16/3/29.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDFlowLayout;
@protocol YDFlowLayoutDelegate <NSObject>

@required
/**
 *  设置每个item的自身高度
 *  @param indexPath 所在的位置
 *  @return 高度
 */
- (CGFloat)itemHeightLayOut:(NSIndexPath *)indexPath;

@end

@interface YDFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign)NSInteger colNum;//列数
@property (nonatomic, assign)CGFloat interSpace;//每个item的间隔
@property (nonatomic, assign)UIEdgeInsets edgeInsets;//整个CollectionView的间隔
@property (nonatomic, weak) id<YDFlowLayoutDelegate> delegate;

@end
