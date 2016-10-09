//
//  ShowImage.m
//  CYCS
//
//  Created by Horus on 16/8/20.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ShowImage.h"

@interface ShowImage ()
{
    NSArray *imageArray;
    int currentIndex;
    UIScrollView *AscrollView;
    UIButton *rightItem;
    UICollectionView *AcollectionView;
    NSMutableArray *imageSaving;
    UIActionSheet *actionSheet;
    CGPoint point;
}

@end

@implementation ShowImage

-(instancetype)initWithArray:(NSArray *)array Index:(int)index
{
    if (self=[super init]) {
        imageArray=array;
        currentIndex=index;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    UILabel *titleIndex=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    titleIndex.text=[NSString stringWithFormat:@"%i/%lu",currentIndex+1,[imageArray[1] count]];
    titleIndex.textColor=[UIColor whiteColor];
    titleIndex.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleIndex;
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
    rightItem=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setTitle:@"小图模式" forState:UIControlStateNormal];
    rightItem.frame=CGRectMake(0, 0, 80, 25);
    [rightItem addTarget:self action:@selector(barRightItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightItem=[[UIBarButtonItem alloc]initWithCustomView:rightItem];
    [self.navigationItem setRightBarButtonItem:barRightItem];
    imageSaving=[NSMutableArray array];
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0), ^{
        for (int i=0; i<[imageArray[1] count]; i++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*i, -30, self.view.bounds.size.width, self.view.bounds.size.height)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;

            NSURL *url=[NSURL URLWithString:[[imageArray[1] objectAtIndex:i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                imageView.image=[UIImage imageWithData:data];
                [imageSaving addObject:imageView];
                [self addScrollView];
            }];
        }
        
    });
    
}

-(void)addScrollView
{
    if ([imageSaving count]==[imageArray[1] count]) {
        AscrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        AscrollView.bounces=YES;
        AscrollView.pagingEnabled=YES;
        AscrollView.delegate=self;
        for (int i=0; i<[imageSaving count]; i++) {
            [AscrollView addSubview:imageSaving[i]];
        }
        AscrollView.contentSize=CGSizeMake(AscrollView.bounds.size.width*[imageArray[1] count], AscrollView.bounds.size.height);
        AscrollView.contentOffset=CGPointMake(AscrollView.bounds.size.width*currentIndex, 0);
        [self.view addSubview:AscrollView];
    }
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    AcollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-20) collectionViewLayout:flowLayout];
    AcollectionView.delegate=self;
    AcollectionView.dataSource=self;
    [AcollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"systemCollectionCell"];
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
    longPress.minimumPressDuration=1.3;
    [AcollectionView addGestureRecognizer:longPress];
    
    [self.view addSubview:AcollectionView];
    
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    currentIndex=scrollView.contentOffset.x/scrollView.bounds.size.width;
    UILabel *titleIndex=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    titleIndex.text=[NSString stringWithFormat:@"%i/%lu",currentIndex+1,[imageArray[1] count]];
    titleIndex.textColor=[UIColor whiteColor];
    titleIndex.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titleIndex;
}

-(void)barRightItemAction
{
    if ([rightItem.titleLabel.text isEqualToString:@"小图模式"]) {
        self.navigationItem.titleView=nil;
        [rightItem setTitle:@"大图模式" forState:UIControlStateNormal];
        [AscrollView removeFromSuperview];
        [self addCollectionView];
    }
    else
    {
        UILabel *titleIndex=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
        titleIndex.text=[NSString stringWithFormat:@"%i/%lu",currentIndex+1,[imageArray[1] count]];
        titleIndex.textColor=[UIColor whiteColor];
        titleIndex.textAlignment=NSTextAlignmentCenter;
        self.navigationItem.titleView=titleIndex;
        [rightItem setTitle:@"小图模式" forState:UIControlStateNormal];
        [AcollectionView removeFromSuperview];
        [self addScrollView];
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [imageArray[0] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"systemCollectionCell";
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    NSURL *url=[NSURL URLWithString:[[imageArray[0] objectAtIndex:indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageWithData:data]];
    }];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(140, 200);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(void)saveImage:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state==UIGestureRecognizerStateBegan) {
    point=[recognizer locationInView:AcollectionView];
    actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册", nil];
    [actionSheet showInView:self.view];
        
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            NSIndexPath *indexpath=[AcollectionView indexPathForItemAtPoint:point];
            NSURL *url=[NSURL URLWithString:[[imageArray[0] objectAtIndex:indexpath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSData *data=[NSData dataWithContentsOfURL:url];
            UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:data], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
            break;
            
        default:
            break;
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    if (!error) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }
    else
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"保存失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}
@end
