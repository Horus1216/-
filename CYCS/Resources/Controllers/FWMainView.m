//
//  FWMainView.m
//  CYCS
//
//  Created by Horus on 16/8/24.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "FWMainView.h"
#import "CHTumblrMenuView.h"

@interface FWMainView ()
{
    CHTumblrMenuView *menuView;
    BOOL isShowMoreList;
}
@end

@implementation FWMainView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self viewDidLoad];
    }
    return self;
}

-(void)viewDidLoad
{
    self.backgroundColor=[UIColor whiteColor];
    if (menuView) {
        [menuView removeFromSuperview];
        menuView=nil;
    }
    menuView=[[CHTumblrMenuView alloc]initWithFrame:self.bounds];
    menuView.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2-40);
    [self addSubview:menuView];
    
    __weak FWMainView *weak=self;
    
    [menuView addMenuItemWithTitle:@"" andIcon:[UIImage imageNamed:@"service_button1"] andSelectedBlock:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(FWMainViewPush:)]) {
            [weak.delegate FWMainViewPush:0];
        }
    }];
    
    [menuView addMenuItemWithTitle:@"" andIcon:[UIImage imageNamed:@"service_button2"] andSelectedBlock:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(FWMainViewPush:)]) {
            [weak.delegate FWMainViewPush:1];
        }
    }];
    [menuView addMenuItemWithTitle:@"" andIcon:[UIImage imageNamed:@"service_button3"] andSelectedBlock:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(FWMainViewPush:)]) {
            [weak.delegate FWMainViewPush:2];
        }
    }];
    [menuView addMenuItemWithTitle:@"" andIcon:[UIImage imageNamed:@"service_button4"] andSelectedBlock:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(FWMainViewPush:)]) {
            [weak.delegate FWMainViewPush:3];
        }
    }];
    [menuView addMenuItemWithTitle:@"" andIcon:[UIImage imageNamed:@"service_button5"] andSelectedBlock:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(FWMainViewPush:)]) {
            [weak.delegate FWMainViewPush:4];
        }
    }];
    [menuView show];
}


@end
