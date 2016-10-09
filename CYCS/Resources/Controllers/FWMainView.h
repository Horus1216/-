//
//  FWMainView.h
//  CYCS
//
//  Created by Horus on 16/8/24.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FWMainViewDelegate <NSObject>

-(void)FWMainViewPush:(NSInteger)index;

@end

@interface FWMainView : UIView

@property(nonatomic,weak) id<FWMainViewDelegate> delegate;

-(void)viewDidLoad;

@end
