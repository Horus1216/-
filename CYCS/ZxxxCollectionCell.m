//
//  ZxxxCollectionCell.m
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ZxxxCollectionCell.h"

@interface ZxxxCollectionCell ()
{
    UIView *totalView;
    UIView *detailView;
    UILabel *label;
    CGRect rect;
}
@end

@implementation ZxxxCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        rect=frame;
        self.backgroundColor=[UIColor whiteColor];
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews
{
    totalView=[[UIView alloc]initWithFrame:CGRectZero];
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(extension:)];
//    [totalView addGestureRecognizer:tap];
    [self addSubview:totalView];
    
    detailView=[[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:detailView];
    
    label=[[UILabel alloc]initWithFrame:CGRectZero];
    [detailView addSubview:label];

}

-(void)setInfo
{
    totalView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-50);
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, totalView.frame.size.width, totalView.frame.size.height)];
    NSURL *url=[NSURL URLWithString:[self.imageURL[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        imageView1.image=[UIImage imageWithData:data];
        [totalView addSubview:imageView1];
    }];
//    for (int i=0; i<[self.imageURL count]; i++) {
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, totalView.frame.size.width, totalView.frame.size.height)];
//        NSURL *url=[NSURL URLWithString:[self.imageURL[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//            imageView.image=[UIImage imageWithData:data];
//            [totalView addSubview:imageView];
//        }];
//    }
    
    detailView.frame=CGRectMake(0, totalView.frame.origin.y+totalView.frame.size.height, totalView.frame.size.width, 50);
    
    label.frame=CGRectMake(0, 0, detailView.frame.size.width-50, 50);
    label.text=self.labelContext;
    label.font=[UIFont systemFontOfSize:13];
    label.numberOfLines=0;
    [detailView addSubview:label];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(label.frame.size.width+5, 5, 40, 40)];
    NSURL *url1=[NSURL URLWithString:[self.LabelImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url1] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        imageView.image=[UIImage imageWithData:data];
        [label addSubview:imageView];
    }];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, detailView.frame.size.width, detailView.frame.size.height);
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [detailView addSubview:btn];
}

-(void)extension:(UITapGestureRecognizer *)tap
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeCell" object:nil];
}

-(void)btnClicked
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ZxxxVCPushVC" object:@[self.wedHtml,self.labelContext,self.wedTime]];
}

@end
