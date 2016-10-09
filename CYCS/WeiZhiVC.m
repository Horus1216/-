//
//  WeiZhiVC.m
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "WeiZhiVC.h"

@interface WeiZhiVC ()
{
    
}
@property(nonatomic,retain) MKMapView *AmapView;

@end

@implementation WeiZhiVC

-(instancetype)initWithArray:(NSArray *)array title:(NSString *)locationTitle
{
    if (self=[super init]) {
        self.coordinateArray=array;
        self.locationTitle=locationTitle;
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
    labelTitle.text=@"位置";
    self.navigationItem.titleView=labelTitle;
    
    self.AmapView=[[MKMapView alloc]initWithFrame:self.view.bounds];
    self.AmapView.delegate=self;
    self.AmapView.mapType=MKMapTypeStandard;
    CLLocationCoordinate2D coordinate=CLLocationCoordinate2DMake([self.coordinateArray[1] floatValue], [self.coordinateArray[0] floatValue]);
    MKCoordinateSpan span=MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region=MKCoordinateRegionMake(coordinate, span);
    [self.AmapView setRegion:[self.AmapView regionThatFits:region] animated:YES];
    
    [self.view addSubview:self.AmapView];
    
    MyAnnotation *annotation=[[MyAnnotation alloc]init];
    [annotation setCoordinate:coordinate];
    [annotation setTitle:self.locationTitle];
    [self.AmapView addAnnotation:annotation];
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
}
-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"获取当前位置失败＝%@", [error localizedDescription]);
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MyAnnotationView *annotationView=(MyAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"customAnnotation"];
    if (!annotationView) {
        annotationView=[[MyAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"customAnnotation" title:self.locationTitle frame:CGRectMake(0, 20, 140, 60)];
        annotationView.draggable=NO;
        annotationView.image=[UIImage imageNamed:@"nearby_location"];
        
    }
        return annotationView;
}


@end
