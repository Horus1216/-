//
//  ZBCollectionView.m
//  CYCS
//
//  Created by Horus on 16/8/23.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ZBCollectionView.h"
#import "ZBCollectionCell.h"
#import "YDFlowLayout.h"

@interface ZBCollectionView ()
{
    UICollectionView *LocalCollectionView;
    int sceneID;
    NSDictionary *savingData;
    NSDictionary *savingDataDetail;
    CGFloat height;
}
@property(nonatomic,retain) SDRefreshHeaderView *RefreshHeaderView;
@property(nonatomic,retain) SDRefreshFooterView *RefreshFooterView;

@end

@implementation ZBCollectionView

-(instancetype)initWithFrame:(CGRect)frame SceneID:(int)whichSceneID
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithRed:200/255.0 green:215/255.0 blue:215/255.0 alpha:0.2];
        sceneID=whichSceneID;
        savingData=[NSDictionary dictionary];
        savingDataDetail=[NSDictionary dictionary];
        [self requestSceneINFO];
    }
    return self;
}

-(void)requestSceneINFO
{
    NSString *urlString=@"http://112.74.108.147:6100/api/surroundingList";
    NSString *getSceneJson=[NSString stringWithFormat:@"p={\"a\":%i,\"b\":1}",sceneID];
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[getSceneJson dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data.length!=0) {
            savingData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            [self addCollectionView];
        }
        
    }];
}

-(void)addCollectionView
{
    YDFlowLayout * layout = [[YDFlowLayout alloc]init];
    layout.interSpace = 10;
    layout.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.colNum = 2;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.delegate = self;
    LocalCollectionView=[[UICollectionView alloc]initWithFrame:self.bounds  collectionViewLayout:layout];
    LocalCollectionView.dataSource=self;
    LocalCollectionView.delegate=self;
    LocalCollectionView.backgroundColor=[UIColor lightGrayColor];
    LocalCollectionView.backgroundColor=self.backgroundColor=[UIColor colorWithRed:200/255.0 green:215/255.0 blue:215/255.0 alpha:0.2];
    [LocalCollectionView registerClass:[ZBCollectionCell class] forCellWithReuseIdentifier:@"SPCollectionViewCell"];
    [self addSubview:LocalCollectionView];
    
    self.RefreshHeaderView=[SDRefreshHeaderView refreshView];
    [self.RefreshHeaderView addToScrollView:LocalCollectionView];
    __weak ZBCollectionView *weak=self;
    self.RefreshHeaderView.beginRefreshingOperation=^{
        [weak performSelector:@selector(refreshData) withObject:nil afterDelay:2.0];
    };
    self.RefreshFooterView=[SDRefreshFooterView refreshView];
    [self.RefreshFooterView addToScrollView:LocalCollectionView];
    self.RefreshFooterView.beginRefreshingOperation=^{
        [weak performSelector:@selector(refreshData) withObject:nil afterDelay:2.0];
    };
}

-(void)refreshData {
    [self.RefreshHeaderView endRefreshing];
    [self.RefreshFooterView endRefreshing];
    NSString *urlString=@"http://112.74.108.147:6100/api/surroundingList";
    NSString *getSceneJson=[NSString stringWithFormat:@"p={\"a\":%i,\"b\":1}",sceneID];
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[getSceneJson dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data.length!=0) {
            savingData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        }
        
    }];
    [LocalCollectionView reloadData];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array=[savingData objectForKey:@"a"];
    return [array count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array=[savingData objectForKey:@"a"];
    NSDictionary *dic=[array objectAtIndex:indexPath.row];
    static NSString *identify=@"SPCollectionViewCell";
    ZBCollectionCell *AcollectionViewCell=[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    NSString *imageURL=[dic objectForKey:@"c"];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        AcollectionViewCell.imageView.image=[UIImage imageWithData:data];
    }];
    AcollectionViewCell.titleLabel.text=[dic objectForKey:@"d"];
    AcollectionViewCell.contentLabel.text=[dic objectForKey:@"e"];
    AcollectionViewCell.contentLabel.textColor=[UIColor lightGrayColor];
    AcollectionViewCell.backgroundColor=[UIColor whiteColor];
    [AcollectionViewCell setView];
    return AcollectionViewCell;
}

-(CGFloat)itemHeightLayOut:(NSIndexPath *)indexPath
{
        NSArray *array=[savingData objectForKey:@"a"];
        NSDictionary *dic=[array objectAtIndex:indexPath.row];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2-10, 200)];
        label.text=[dic objectForKey:@"e"];
        label.font=[UIFont systemFontOfSize:12];
        height=[self getHeight:label];
        if (height<200) {
            return height;
        }
    return 200;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   [self detailInfo:(int)indexPath.row];
}

-(void)detailInfo:(int)row
{
    NSArray *array=[savingData objectForKey:@"a"];
    NSDictionary *dic=[array objectAtIndex:row];
    int detailSceneID=[[dic objectForKey:@"b"] intValue];
    NSString *urlString=@"http://112.74.108.147:6100/api/surroundingDetail";
    NSString *getSceneJson=[NSString stringWithFormat:@"p={\"a\":%i}",detailSceneID];
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[getSceneJson dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data.length!=0) {
            savingDataDetail=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushViewZBDetail" object:nil userInfo:savingDataDetail];
        }
    }];
    
}

-(CGFloat)getHeight:(UILabel *)label
{
    NSDictionary *atrribute=@{NSFontAttributeName:label.font};
    CGSize size=[label.text boundingRectWithSize:CGSizeMake(self.frame.size.width/2-10, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:atrribute context:nil].size;
    return size.height+60;
}

@end
