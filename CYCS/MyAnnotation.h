//
//  MyAnnotation.h
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject  <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
-(void)setTitle:(NSString * _Nullable)title;

@end
