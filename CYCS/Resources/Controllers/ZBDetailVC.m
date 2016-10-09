//
//  ZBDetailVC.m
//  CYCS
//
//  Created by Horus on 16/8/23.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "ZBDetailVC.h"

@interface ZBDetailVC ()
{
    NSDictionary *infoDic;
    UIScrollView *AscrollView;
    UIPageControl *pageController;
    UIButton *weizhi;
    UIButton *dianhua;
    UIButton *jianjie;
    NSMutableArray *scrollImage;
}

@property(nonatomic,retain) UIWebView *webTel;

@end

@implementation ZBDetailVC

-(instancetype)initWithDictionary:(NSDictionary *)info
{
    if (self=[super init]) {
        
        infoDic=[NSDictionary dictionaryWithDictionary:[info objectForKey:@"a"]];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=[infoDic objectForKey:@"d"];
    self.navigationItem.titleView=labelTitle;
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
    NSArray *scrollImageOrigin=[infoDic objectForKey:@"f"];
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
    
    //    for (int i=0; i<[scrollImage count]; i++) {
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[scrollImage[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, AscrollView.bounds.size.width, AscrollView.bounds.size.height)];
    imageView.image=[UIImage imageWithData:data];
    [AscrollView addSubview:imageView];
    //    }
    
    pageController=[[UIPageControl alloc]initWithFrame:CGRectZero];
    int pages=(int)[scrollImage count];
    CGSize size=[pageController sizeForNumberOfPages:pages];
    pageController.frame=CGRectMake((AscrollView.bounds.size.width-size.width)/2, AscrollView.bounds.size.height-size.height, size.width, size.height);
    pageController.numberOfPages=pages;
    pageController.currentPage=0;
    pageController.pageIndicatorTintColor=[UIColor whiteColor];
    pageController.currentPageIndicatorTintColor=[UIColor greenColor];
    [mainScroll addSubview:pageController];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, AscrollView.frame.origin.y+AscrollView.frame.size.height+5, self.view.bounds.size.width, 20)];
    label.text=@"概况";
    label.backgroundColor=[UIColor clearColor];
    [self.view addSubview:label];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, label.frame.origin.y+label.frame.size.height, self.view.bounds.size.width, 50)];
    label1.text=[NSString stringWithFormat:@"参考价格:%@\n住所类型:%@\n交通信息:%@",[infoDic objectForKey:@"k"],[infoDic objectForKey:@"i"],[infoDic objectForKey:@"j"]];
    label1.font=[UIFont systemFontOfSize:12];
    label1.numberOfLines=0;
    [self.view addSubview:label1];
    
    weizhi=[UIButton buttonWithType:UIButtonTypeCustom];
    weizhi.frame=CGRectMake(0, label1.frame.origin.y+label1.frame.size.height, self.view.bounds.size.width, 40);
    [weizhi setBackgroundImage:[UIImage imageNamed:@"nearby_detail_line"] forState:UIControlStateNormal];
    [weizhi setTitle:[NSString stringWithFormat:@"   位置：%@",[infoDic objectForKey:@"t"]] forState:UIControlStateNormal];
    [weizhi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    weizhi.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    weizhi.titleLabel.font=[UIFont systemFontOfSize:13];
    [weizhi addTarget:self action:@selector(weizhiButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weizhi];
    
    UIImageView *accessory2=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-12, (weizhi.bounds.size.height-14)/2, 9, 14)];
    accessory2.image=[UIImage imageNamed:@"tongyong_arrow"];
    [weizhi addSubview:accessory2];
    
    NSMutableString *phone=[NSMutableString string];
    for (NSString *string in [infoDic objectForKey:@"p"]) {
        [phone appendFormat:@"%@ ",string];
    }
    dianhua=[UIButton buttonWithType:UIButtonTypeCustom];
    dianhua.frame=CGRectMake(0, weizhi.frame.origin.y+weizhi.frame.size.height, self.view.bounds.size.width, 40);
    [dianhua setBackgroundImage:[UIImage imageNamed:@"nearby_detail_line"] forState:UIControlStateNormal];
    [dianhua setTitle:[NSString stringWithFormat:@"   电话：%@",phone] forState:UIControlStateNormal];
    [dianhua setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    dianhua.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    dianhua.titleLabel.font=[UIFont systemFontOfSize:13];
    [dianhua addTarget:self action:@selector(dianhuabutton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dianhua];
    
    UIImageView *imageBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, dianhua.frame.origin.y+dianhua.frame.size.height, self.view.bounds.size.width, 60)];
    imageBack.image=[UIImage imageNamed:@"nearby_detail_line"];
    imageBack.userInteractionEnabled=YES;
    [self.view addSubview:imageBack];
    
    UILabel *jianjieLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, imageBack.bounds.size.width-29, imageBack.bounds.size.height-5)];
    jianjieLabel.text=[NSString stringWithFormat:@"简介\n%@",[infoDic objectForKey:@"e"]];
    jianjieLabel.font=[UIFont systemFontOfSize:13];
    jianjieLabel.numberOfLines=0;
    [imageBack addSubview:jianjieLabel];
    
    UIImageView *accessory3=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-12, (imageBack.bounds.size.height-14)/2, 9, 14)];
    accessory3.image=[UIImage imageNamed:@"tongyong_arrow"];
    [imageBack addSubview:accessory3];
    
    jianjie=[UIButton buttonWithType:UIButtonTypeCustom];
    jianjie.backgroundColor=[UIColor clearColor];
    jianjie.frame=CGRectMake(0, 0, imageBack.bounds.size.width, imageBack.bounds.size.height);
    [jianjie addTarget:self action:@selector(jianjieButton) forControlEvents:UIControlEventTouchUpInside];
    [imageBack addSubview:jianjie];
    
    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

-(void)dianhuabutton
{
    NSArray *phone=[infoDic objectForKey:@"p"];
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"拨打电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:phone[0],phone[1], nil];
    [actionSheet showInView:self.view];
}

-(void)jianjieButton
{
    JianjieVC *vc=[[JianjieVC alloc]initWithString:[infoDic objectForKey:@"e"]];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)weizhiButton
{
    WeiZhiVC *vc=[[WeiZhiVC alloc]initWithArray:@[[infoDic objectForKey:@"n"],[infoDic objectForKey:@"o"]] title:[infoDic objectForKey:@"t"]];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showScrollImage
{
    NSArray *scrollImageOriginMin=[infoDic objectForKey:@"f"];
    NSMutableArray *scrollImageMin=[NSMutableArray array];
    for (NSString *string in scrollImageOriginMin) {
        if (string.length!=0) {
            [scrollImageMin addObject:string];
        }
    }
    NSArray *scrollImageOriginMax=[infoDic objectForKey:@"g"];
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

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageController.currentPage=scrollView.contentOffset.x/scrollView.bounds.size.width;
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

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.webTel = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[actionSheet buttonTitleAtIndex:buttonIndex]]];
    [self.webTel loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}



@end
