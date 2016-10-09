//
//  ZBMainView.m
//  CYCS
//
//  Created by Horus on 16/8/23.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ZBMainView.h"
#import "ZBCollectionView.h"

#define ColorRGB(x, y, z, alp) [UIColor colorWithRed:(x)/255.0 green:(y)/255.0 blue:(z)/255.0 alpha:(alp)]

@interface ZBMainView ()
{
    UICollectionView *collectionView;
}
@property(nonatomic,retain) UIScrollView *titleScroll;
@property(nonatomic,retain) UIScrollView *contentScroll;
@property(nonatomic,retain) UIImageView *seletedIV;

@end

@implementation ZBMainView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self=[super initWithFrame:frame]) {
        [self viewDidLoad];
    }
    return self;
}

- (void)viewDidLoad {
    
    self.backgroundColor=[UIColor lightGrayColor];
    
    self.titleScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    self.titleScroll.showsHorizontalScrollIndicator=NO;
    self.titleScroll.backgroundColor=[UIColor whiteColor];
    NSArray *menu = @[@"住宿",@"美食",@"购物",@"娱乐"];
    for(int i = 0; i < menu.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*80, 5, 80, 30);
        btn.tag = 777+i;
        [btn setTitle:menu[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:ColorRGB(41, 170, 168, 1.0) forState:UIControlStateHighlighted];
        [btn setTitleColor:ColorRGB(41, 170, 168, 1.0) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [self.titleScroll addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
        }
    }
    self.titleScroll.contentSize = CGSizeMake(menu.count*80, 40);
    [self addSubview:self.titleScroll];
    
    self.seletedIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, 80, 2)];
    self.seletedIV.backgroundColor = ColorRGB(41, 170, 168, 1.0);
    [self.titleScroll addSubview:self.seletedIV];
    
    self.contentScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height-104)];
    self.contentScroll.delegate=self;
    self.contentScroll.bounces=YES;
    self.contentScroll.pagingEnabled=YES;
    self.contentScroll.showsHorizontalScrollIndicator=NO;
    self.contentScroll.contentSize=CGSizeMake(4*self.bounds.size.width, 0);
    for (int i=0; i<4; i++) {
        ZBCollectionView *collection=[[ZBCollectionView alloc]initWithFrame:CGRectMake(self.contentScroll.bounds.size.width*i, 0, self.contentScroll.bounds.size.width, self.contentScroll.bounds.size.height) SceneID:i];
        [self.contentScroll addSubview:collection];
    }
    [self addSubview:self.contentScroll];
}
- (void)buttonClicked:(UIButton*)button
{
    [self.titleScroll.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton *)obj;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (btn==button) {
                    btn.selected=YES;
                }
                else
                {
                    btn.selected=NO;
                }
            });
            
        }
    }];
    int index = (int)(button.tag-777);
    [self.contentScroll setContentOffset:CGPointMake(index*self.bounds.size.width, 0) animated:NO];
    [self scrollViewDidEndDecelerating:self.contentScroll];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/self.bounds.size.width;
    if (scrollView==self.contentScroll) {
        self.seletedIV.frame = CGRectMake(self.contentScroll.contentOffset.x/self.bounds.size.width*80, 38, 80, 2);
    }
    
    [self.titleScroll.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton *)obj;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (btn.tag==index+777) {
                    btn.selected=YES;
                }
                else
                {
                    btn.selected=NO;
                }
            });
            
        }
    }];
}


@end
