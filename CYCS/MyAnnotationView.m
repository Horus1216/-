//
//  MyAnnotationView.m
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "MyAnnotationView.h"

@implementation MyAnnotationView

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)content frame:(CGRect)rect
{
    self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.content=content;
        self.frame=rect;
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews
{
    self.canShowCallout=NO;
    UIImageView *image=[[UIImageView alloc]initWithFrame:self.bounds];
    image.image=[UIImage imageNamed:@"nearby_location2"];
    [self addSubview:image];
    
    UILabel *label=[[UILabel alloc]initWithFrame:self.bounds];
    label.text=self.content;
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.center=CGPointMake(self.center.x, self.center.y-30);
    [self addSubview:label];
}


@end
