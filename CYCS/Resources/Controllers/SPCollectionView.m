//
//  SPCollectionView.m
//  CYCS
//
//  Created by Horus on 16/8/22.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "SPCollectionView.h"
#import "SPCollectionViewCell.h"
#import "WatchDog.h"

@interface SPCollectionView ()
{
    UICollectionView *LocalCollectionView;
    int sceneID;
    NSDictionary *savingData;
    NSDictionary *savingDataDetail;
}
@property(nonatomic,retain) SDRefreshHeaderView *RefreshHeaderView;
@property(nonatomic,retain) SDRefreshFooterView *RefreshFooterView;

@end

@implementation SPCollectionView

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
    NSString *urlString=@"http://112.74.108.147:6100/api/videolist";
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
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    LocalCollectionView=[[UICollectionView alloc]initWithFrame:self.bounds  collectionViewLayout:flowLayout];
    LocalCollectionView.dataSource=self;
    LocalCollectionView.delegate=self;
    LocalCollectionView.backgroundColor=[UIColor lightGrayColor];
    LocalCollectionView.backgroundColor=self.backgroundColor=[UIColor colorWithRed:200/255.0 green:215/255.0 blue:215/255.0 alpha:0.2];
    [LocalCollectionView registerClass:[SPCollectionViewCell class] forCellWithReuseIdentifier:@"SPCollectionViewCell"];
    [self addSubview:LocalCollectionView];
    
    self.RefreshHeaderView=[SDRefreshHeaderView refreshView];
    [self.RefreshHeaderView addToScrollView:LocalCollectionView];
    __weak SPCollectionView *weak=self;
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
    [LocalCollectionView reloadData];
    [self.RefreshHeaderView endRefreshing];
    [self.RefreshFooterView endRefreshing];
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
    SPCollectionViewCell *AcollectionViewCell=[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    NSString *imageURL=[dic objectForKey:@"c"];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        AcollectionViewCell.imageView.image=[UIImage imageWithData:data];
    }];
    AcollectionViewCell.titleLabel.text=[dic objectForKey:@"d"];
    AcollectionViewCell.contentLabel.text=[dic objectForKey:@"f"];
    AcollectionViewCell.contentLabel.textColor=[UIColor lightGrayColor];
    AcollectionViewCell.backgroundColor=[UIColor whiteColor];
    return AcollectionViewCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.bounds.size.width-10, 70);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL noDirectory=NO;
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *wifiRequired=[NSString stringWithFormat:@"%@/wifiRequired.tag",library];
    NSString *wifiNotRequired=[NSString stringWithFormat:@"%@/wifiNotRequired.tag",library];
    NSString *net=[[WatchDog luckDog]currentNetwork];
    if ([manager fileExistsAtPath:wifiRequired isDirectory:&noDirectory]) {
        if ([net isEqualToString:@"wifi"]) {
            NSArray *array=[savingData objectForKey:@"a"];
            NSString *VideoUrl=[array[0] objectForKey:@"e"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"SPMoviePush" object:@[VideoUrl,[array[0] objectForKey:@"d"]] userInfo:nil];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"视频只能在wifi下播放，设置中可以取消wifi设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
    if ([manager fileExistsAtPath:wifiNotRequired isDirectory:&noDirectory]) {
        NSArray *array=[savingData objectForKey:@"a"];
        NSString *VideoUrl=[array[0] objectForKey:@"e"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SPMoviePush" object:@[VideoUrl,[array[0] objectForKey:@"d"]] userInfo:nil];
    }
}


@end
