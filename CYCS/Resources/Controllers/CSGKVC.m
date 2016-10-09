//
//  CSGKVC.m
//  CYCS
//
//  Created by mac2015 on 16/8/27.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "CSGKVC.h"

@interface CSGKVC ()
{
    NSDictionary *infoDic;
    UIScrollView *AscrollView;
    UIPageControl *pageController;
    NSMutableArray *scrollImage;
}

@end

@implementation CSGKVC

-(instancetype)initWithDictionary:(NSDictionary *)info
{
    if (self=[super init]) {
        
        infoDic=[NSDictionary dictionaryWithDictionary:[info objectForKey:@"a"]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=@"长寿概况";
    self.navigationItem.titleView=labelTitle;
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
    NSArray *scrollImageOrigin=[infoDic objectForKey:@"b"];
    scrollImage=[NSMutableArray array];
    for (NSString *string in scrollImageOrigin) {
        if (string.length!=0) {
            [scrollImage addObject:string];
        }
    }
    UIScrollView *mainScroll=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    mainScroll.showsVerticalScrollIndicator=NO;
    mainScroll.contentSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-64);
    [self.view addSubview:mainScroll];
    
    AscrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180)];
    AscrollView.showsHorizontalScrollIndicator=NO;
    AscrollView.bounces=YES;
    AscrollView.pagingEnabled=YES;
    AscrollView.delegate=self;
    AscrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tongyong_photo"]];
    AscrollView.contentSize=CGSizeMake(self.view.bounds.size.width*[scrollImage count], 180);
    [mainScroll addSubview:AscrollView];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showScrollImage)];
    [AscrollView addGestureRecognizer:tapGesture];
    
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[scrollImage[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, AscrollView.bounds.size.width, AscrollView.bounds.size.height)];
    imageView.image=[UIImage imageWithData:data];
    [AscrollView addSubview:imageView];
    
    pageController=[[UIPageControl alloc]initWithFrame:CGRectZero];
    int pages=(int)[scrollImage count];
    CGSize size=[pageController sizeForNumberOfPages:pages];
    pageController.frame=CGRectMake((AscrollView.bounds.size.width-size.width)/2, AscrollView.bounds.size.height-size.height, size.width, size.height);
    pageController.numberOfPages=pages;
    pageController.currentPage=0;
    pageController.pageIndicatorTintColor=[UIColor whiteColor];
    pageController.currentPageIndicatorTintColor=[UIColor greenColor];
    [mainScroll addSubview:pageController];
    
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, AscrollView.frame.origin.y+AscrollView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-AscrollView.frame.origin.y-AscrollView.frame.size.height-64)];
    webView.backgroundColor=[UIColor clearColor];
    [webView loadHTMLString:[infoDic objectForKey:@"d"] baseURL:nil];
    [self.view addSubview:webView];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageController.currentPage=scrollView.contentOffset.x/scrollView.bounds.size.width;
}

-(void)showScrollImage
{
    NSArray *scrollImageOriginMin=[infoDic objectForKey:@"b"];
    NSMutableArray *scrollImageMin=[NSMutableArray array];
    for (NSString *string in scrollImageOriginMin) {
        if (string.length!=0) {
            [scrollImageMin addObject:string];
        }
    }
    NSArray *scrollImageOriginMax=[infoDic objectForKey:@"c"];
    NSMutableArray *scrollImageMax=[NSMutableArray array];
    for (NSString *string in scrollImageOriginMax) {
        if (string.length!=0) {
            [scrollImageMax addObject:string];
        }
    }
    int index=AscrollView.contentOffset.x/AscrollView.bounds.size.width;
    ShowImage *showImage=[[ShowImage alloc]initWithArray:@[scrollImageMin,scrollImageMax] Index:index];
    [self.navigationController pushViewController:showImage animated:YES];
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for (int i=0; i<[scrollImage count]; i++) {
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[scrollImage[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(AscrollView.bounds.size.width*i, 0, AscrollView.bounds.size.width, AscrollView.bounds.size.height)];
        imageView.image=[UIImage imageWithData:data];
        [AscrollView addSubview:imageView];
    }
}


@end
