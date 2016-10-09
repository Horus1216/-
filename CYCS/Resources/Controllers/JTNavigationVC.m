//
//  JTNavigationVC.m
//  CYCS
//
//  Created by Horus on 16/8/27.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "JTNavigationVC.h"
#define ApiKey @"d4b8338f856afe094e7a6ee4cba1cecc"

@interface JTNavigationVC ()
{
    CLLocationCoordinate2D coordinate;
}
@property (nonatomic, strong) NSMutableArray *lines;
@end

@implementation JTNavigationVC

-(instancetype)initWithBeginLocation:(NSString *)beginLocation EndLocation:(NSString *)endLocation NavigationStyle:(NSString *)navigationStyle
{
    if (self=[super init]) {
        self.beginLocation=beginLocation;
        self.endLocation=endLocation;
        self.navigationStyle=navigationStyle;
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
    labelTitle.text=@"交通路线导航";
    self.navigationItem.titleView=labelTitle;
    
    UIButton *backitem=[UIButton buttonWithType:UIButtonTypeCustom];
    [backitem setBackgroundImage:[UIImage imageNamed:@"tongyong_back-button"] forState:UIControlStateNormal];
    backitem.frame=CGRectMake(0, 0, 25, 25);
    [backitem addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barleftItem=[[UIBarButtonItem alloc]initWithCustomView:backitem];
    [self.navigationItem setLeftBarButtonItem:barleftItem];
    
    [MAMapServices sharedServices].apiKey = ApiKey;
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.mapType = MAMapTypeStandard;
    self.mapView.showTraffic = NO;
    self.mapView.showsCompass= NO;
    self.mapView.showsScale= NO;
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:self.mapView];
    CLGeocoder *coder=[[CLGeocoder alloc]init];
    [coder geocodeAddressString:self.beginLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count==0) {
            NSLog(@"没找到地方啊");
            return ;
        }
        CLPlacemark *placeMark=[placemarks firstObject];
        coordinate=CLLocationCoordinate2DMake(placeMark.location.coordinate.latitude, placeMark.location.coordinate.longitude);
        [self searchTraffic];
    }];
    

}

-(void)searchTraffic
{
    NSLog(@"%f,%f\n",coordinate.longitude,coordinate.latitude);
    MACoordinateSpan span = MACoordinateSpanMake(0.01, 0.01);
    [self.mapView setRegion:MACoordinateRegionMake(coordinate, span) animated:YES];
    
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:ApiKey Delegate:self];
    
    AMapNavigationSearchRequest *naviRequest= [[AMapNavigationSearchRequest alloc] init];
    if ([self.navigationStyle isEqualToString:@"AMapSearchType_NaviDrive"]) {
        naviRequest.searchType = AMapSearchType_NaviDrive;
    }
    else
    {
        naviRequest.searchType = AMapSearchType_NaviWalking;
    }
    naviRequest.strategy = 0;
    naviRequest.requireExtension = NO;
    naviRequest.origin = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    naviRequest.destination = [AMapGeoPoint locationWithLatitude:29.827882 longitude:107.071527];
    [self.search AMapNavigationSearch:naviRequest];
}

-(void)backItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showLines
{
    [self addAnnotation];
    [self drawMapLine];
}


- (void)addAnnotation
{
    NSString *origin = [self.lines firstObject];
    NSArray *ary1 = [origin componentsSeparatedByString:@","];
    CLLocationDegrees latitude = [[ary1 lastObject] floatValue];
    CLLocationDegrees longitude = [[ary1 firstObject] floatValue];
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    annotation.title = self.beginLocation;
    [self.mapView addAnnotation:annotation];
    
    NSString *destination = [self.lines lastObject];
    NSArray *ary2 = [destination componentsSeparatedByString:@","];
    latitude = [[ary2 lastObject] floatValue];
    longitude = [[ary2 firstObject] floatValue];
    annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    annotation.title = self.endLocation;
    [self.mapView addAnnotation:annotation];
}

- (void)drawMapLine
{
    if (self.lines && [self.lines count])
    {
        NSUInteger count = [self.lines count];
        CLLocationCoordinate2D polylineCoords[count];
        
        for (int i = 0; i < count; i++)
        {
            NSString *line = [self.lines objectAtIndex:i];
            NSArray *ary = [line componentsSeparatedByString:@","];
            CLLocationDegrees latitude = [[ary lastObject] floatValue];
            CLLocationDegrees longitude = [[ary firstObject] floatValue];
            polylineCoords[i].latitude = latitude;
            polylineCoords[i].longitude = longitude;
        }
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:polylineCoords count:count];
        [self.mapView addOverlay:polyline];
        self.mapView.visibleMapRect = polyline.boundingMapRect;
    }
}

#pragma mark - AMapSearchDelegate
- (void)onNavigationSearchDone:(AMapNavigationSearchRequest*)request response:(AMapNavigationSearchResponse *)response
{
    if(response.route != nil)
    {
        NSArray *ary = response.route.paths;
        if (ary && [ary count])
        {
            self.lines = [NSMutableArray array];
            for (AMapPath *path in ary)
            {
                for (AMapStep *step in path.steps)
                {
                    NSString *polyline = step.polyline;
                    NSArray *stepLines = [polyline componentsSeparatedByString:@";"];
                    
                    [self.lines addObjectsFromArray:stepLines];
                }
            }
            
            AMapGeoPoint *origin = response.route.origin;
            [self.lines insertObject:[NSString stringWithFormat:@"%f,%f", origin.longitude, origin.latitude]
                             atIndex:0];
            AMapGeoPoint *destination = response.route.destination;
            [self.lines insertObject:[NSString stringWithFormat:@"%f,%f", destination.longitude, destination.latitude] atIndex:[self.lines count]];
            [self showLines];
        }
    }
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *indetifier = @"myIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:indetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:indetifier];
        }
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        return annotationView;
    }
    
    return nil;
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        polylineView.lineWidth = 5.0;
//        polylineView.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.6];
        polylineView.strokeColor=[UIColor redColor];
        polylineView.lineJoinType = kMALineJoinRound;
        polylineView.lineCapType = kMALineCapRound;
        return polylineView;
    }
    
    return nil;
}

@end
