//
//  MyAnnotation.m
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate 
{
    _coordinate=newCoordinate;
}
-(void)setTitle:(NSString *)title
{
    _title=title;
}

@end
