//
//  ZxxxVC.m
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ZxxxVC.h"
#import "ListView.h"
#import "ZxxxCollectionCell.h"
#import "ZxxxVCDetail.h"
#import "SDRefresh.h"
#import "LoginAndRegester.h"

@interface ZxxxVC ()
{
    BOOL isShowMoreList;
    UICollectionView *AcollectionView;
    NSMutableArray *savingData;
}
@property(nonatomic,retain) SDRefreshHeaderView *RefreshHeaderView;
@property(nonatomic,retain) SDRefreshFooterView *RefreshFooterView;

@end

@implementation ZxxxVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(msgAction:) name:@"ZxxxVCPushVC" object:nil];
    isShowMoreList=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topBg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent=NO;
    UILabel *topTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    topTitle.text=@"最新消息";
    topTitle.textColor=[UIColor whiteColor];
    self.navigationItem.titleView=topTitle;
    
    UIButton *leftItemBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftItemBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    leftItemBtn.frame=CGRectMake(0, 0, 20, 20);
    [leftItemBtn addTarget:self action:@selector(leftItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftItemBtn];
    [self.navigationItem setLeftBarButtonItem:leftItem animated:YES];
    
    if (savingData) {
        [savingData removeAllObjects];
        savingData=nil;
    }
    savingData=[NSMutableArray array];
    NSString *urlString=@"http://112.74.108.147:6100/api/newsList";
    NSString *getSceneJson=[NSString stringWithFormat:@"p={\"a\":%i}",1];
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[getSceneJson dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data.length!=0) {
            NSArray *array1=[[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"b"];
            NSArray *array2=[[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"j"];
            [savingData addObjectsFromArray:array1];
            [savingData addObjectsFromArray:array2];
            [self addCollectionView];
        }
    }];
    

}


-(void)msgAction:(NSNotification *)msg
{
    ZxxxVCDetail *vc=[[ZxxxVCDetail alloc]initWthString:msg.object];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addCollectionView
{
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    AcollectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    AcollectionView.backgroundColor=[UIColor lightGrayColor];
    AcollectionView.delegate=self;
    AcollectionView.dataSource=self;
    [AcollectionView registerClass:[ZxxxCollectionCell class] forCellWithReuseIdentifier:@"ZxxxCollectionCell"];
    [self.view addSubview:AcollectionView];
    
    self.RefreshHeaderView=[SDRefreshHeaderView refreshView];
    [self.RefreshHeaderView addToScrollView:AcollectionView];
    __weak ZxxxVC *weak=self;
    self.RefreshHeaderView.beginRefreshingOperation=^{
        [weak performSelector:@selector(refreshData) withObject:nil afterDelay:2.0];
    };
    self.RefreshFooterView=[SDRefreshFooterView refreshView];
    [self.RefreshFooterView addToScrollView:AcollectionView];
    self.RefreshFooterView.beginRefreshingOperation=^{
        [weak performSelector:@selector(refreshData) withObject:nil afterDelay:2.0];
    };
    ListView *listView=[[ListView alloc]initWithFrame:CGRectMake(0, -64, self.view.bounds.size.width-80, self.view.bounds.size.height+64)];
    [self.view addSubview:listView];
    [self.view sendSubviewToBack:listView];
}

-(void)refreshData {
    [self.RefreshHeaderView endRefreshing];
    [self.RefreshFooterView endRefreshing];
    [AcollectionView reloadData];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [savingData count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"ZxxxCollectionCell";
    NSDictionary *dic=[savingData objectAtIndex:indexPath.section];
    NSArray *imageArray=[dic objectForKey:@"h"];
    ZxxxCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.imageURL=imageArray;
    cell.labelContext=[dic objectForKey:@"e"];
    cell.LabelImage=[dic objectForKey:@"d"];
    cell.wedHtml=[dic objectForKey:@"g"];
    cell.wedTime=[dic objectForKey:@"f"];
    [cell setInfo];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width-30, 160);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 0, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(void)leftItemClicked:(UIButton *)button
{
    if (isShowMoreList==YES) {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 0);
            AcollectionView.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 0);
            
        }];
        
        isShowMoreList=NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.transform=CGAffineTransformMakeTranslation(0, 0);
            AcollectionView.transform=CGAffineTransformMakeTranslation(0, 0);
        }];
        isShowMoreList=YES;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    BOOL noDirectory=NO;
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *Loginned=[NSString stringWithFormat:@"%@/Loginned.tag",library];
    
    if ([manager fileExistsAtPath:Loginned isDirectory:&noDirectory]) {
        return;
    }
    else
    {
        LoginAndRegester *loginView=[[LoginAndRegester alloc]init];
        [self presentViewController:loginView animated:YES completion:^{
            
        }];
//        static dispatch_once_t once;
//        dispatch_once(&once, ^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                LoginAndRegester *loginView=[[LoginAndRegester alloc]init];
//                [self presentViewController:loginView animated:YES completion:^{
//                    
//                }];
//            });
//        });
    }
}

@end
