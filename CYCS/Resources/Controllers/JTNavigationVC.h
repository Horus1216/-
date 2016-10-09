//
//  JTNavigationVC.h
//  CYCS
//
//  Created by Horus on 16/8/27.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface JTNavigationVC : UIViewController<MAMapViewDelegate,AMapSearchDelegate>

@property(nonatomic,retain) NSString *beginLocation;
@property(nonatomic,retain) NSString *endLocation;
@property(nonatomic,retain) NSString *navigationStyle;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

-(instancetype)initWithBeginLocation:(NSString *)beginLocation EndLocation:(NSString *)endLocation NavigationStyle:(NSString *)navigationStyle;


@end
