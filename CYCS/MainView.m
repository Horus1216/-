//
//  MainView.m
//  CYCS
//
//  Created by Horus on 16/8/18.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "MainView.h"

#define ColorRGB(x, y, z, alp) [UIColor colorWithRed:(x)/255.0 green:(y)/255.0 blue:(z)/255.0 alpha:(alp)]

@interface MainView ()
{
    BOOL isShowMoreList;
}
@property(nonatomic,retain) UIScrollView *titleScroll;
@property(nonatomic,retain) UIScrollView *contentScroll;
@property(nonatomic,retain) UIImageView *seletedIV;


@end

@implementation MainView

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        [self viewDidLoad];
    }
    return self;
}

- (void)viewDidLoad {
    
    isShowMoreList=YES;
    self.backgroundColor=[UIColor lightGrayColor];
    
    self.titleScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    self.titleScroll.showsHorizontalScrollIndicator=NO;
    self.titleScroll.backgroundColor=[UIColor whiteColor];
    NSArray *menu = @[@"长寿湖景区",@"大洪湖景区",@"菩提山景区",@"滨江长寿谷",@"长寿快乐谷",@"其他的景区"];
    for(int i = 0; i < menu.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*90, 5, 80, 30);
        btn.tag = 888+i;
        [btn setTitle:menu[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:ColorRGB(41, 170, 168, 1.0) forState:UIControlStateHighlighted];
        [btn setTitleColor:ColorRGB(41, 170, 168, 1.0) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScroll addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
        }
    }
    self.titleScroll.contentSize = CGSizeMake(menu.count*90, 40);
    [self addSubview:self.titleScroll];
    
    self.seletedIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, 80, 2)];
    self.seletedIV.backgroundColor = ColorRGB(41, 170, 168, 1.0);
    [self.titleScroll addSubview:self.seletedIV];
    
    self.contentScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height-104)];
    self.contentScroll.delegate=self;
    self.contentScroll.bounces=YES;
    self.contentScroll.pagingEnabled=YES;
    self.contentScroll.showsHorizontalScrollIndicator=NO;
    self.contentScroll.contentSize=CGSizeMake(6*self.bounds.size.width, 0);
    for (int i=1; i<7; i++) {
        CollectionView *collection=[[CollectionView alloc]initWithFrame:CGRectMake(self.contentScroll.bounds.size.width*(i-1), 0, self.contentScroll.bounds.size.width, self.contentScroll.bounds.size.height) SceneID:i];
        [self.contentScroll addSubview:collection];
    }
    [self addSubview:self.contentScroll];
}


-(void)leftItemClicked:(UIButton *)button
{
    if (isShowMoreList==YES) {
        [UIView animateWithDuration:0.5 animations:^{
            self.transform=CGAffineTransformMakeTranslation(self.bounds.size.width-100, 0);
        }];
        
        isShowMoreList=NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.transform=CGAffineTransformMakeTranslation(0, 0);
        }];
        isShowMoreList=YES;
    }
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
    int index = (int)(button.tag-888);
    [self.contentScroll setContentOffset:CGPointMake(index*self.bounds.size.width, 0) animated:NO];
    [self scrollViewDidEndDecelerating:self.contentScroll];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/self.bounds.size.width;
    if (scrollView==self.contentScroll) {
        self.seletedIV.frame = CGRectMake(self.contentScroll.contentOffset.x/self.bounds.size.width*90, 38, 80, 2);
        if (index == 1) {
            [self.titleScroll setContentOffset:CGPointMake(0, 0) animated:YES];
        } else if (index == 3) {
            [self.titleScroll setContentOffset:CGPointMake(120, 0) animated:YES];
        } else if (index == 4) {
            [self.titleScroll setContentOffset:CGPointMake(self.titleScroll.contentSize.width-self.titleScroll.bounds.size.width, 0) animated:YES];
        }
    }
    
    [self.titleScroll.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton *)obj;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (btn.tag==index+888) {
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
