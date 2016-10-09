//
//  WeiZhiVC.h
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "MyAnnotationView.h"

@interface WeiZhiVC : UIViewController<MKMapViewDelegate>

@property(nonatomic,retain) NSArray *coordinateArray;
@property(nonatomic,retain) NSString *locationTitle;

-(instancetype)initWithArray:(NSArray *)array title:(NSString *)locationTitle;

@end
