//
//  MyAnnotationView.h
//  CYCS
//
//  Created by Horus on 16/8/21.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MyAnnotationView : MKAnnotationView

@property(nonatomic,retain) NSString *content;

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)content frame:(CGRect)rect;

@end
