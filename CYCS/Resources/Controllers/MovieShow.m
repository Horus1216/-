//
//  MovieShow.m
//  CYCS
//
//  Created by Horus on 16/8/22.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "MovieShow.h"

@interface MovieShow ()

@property(nonatomic,retain)MPMoviePlayerController *movie;

@end

@implementation MovieShow

-(instancetype)initWthString:(NSArray *)string
{
    if (self=[super init]) {
        self.movieURL=string;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    labelTitle.textColor=[UIColor whiteColor];
    labelTitle.textAlignment=NSTextAlignmentCenter;
    labelTitle.text=self.movieURL[1];
    self.navigationItem.titleView=labelTitle;
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
    if (self.movie) {
        [self.movie.view removeFromSuperview];
        self.movie=nil;
    }
    self.movie=[[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:[self.movieURL[0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    self.movie.view.frame=CGRectMake(0, -64, self.view.bounds.size.width, self.view.bounds.size.height);
    self.movie.controlStyle=MPMovieControlStyleEmbedded;
    self.movie.scalingMode=MPMovieScalingModeAspectFit;
    [self.view addSubview:self.movie.view];
    [self.movie prepareToPlay];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFinished) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playerFinished
{
    [self.movie.view removeFromSuperview];
    self.movie=nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (size.width<size.height) {
        self.movie.view.frame=CGRectMake(0, -34, size.width,size.height);
    }
    else
    {
        self.movie.view.frame=CGRectMake(0, 30, size.width, size.height);
    }
}



@end
