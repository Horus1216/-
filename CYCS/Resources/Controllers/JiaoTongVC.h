//
//  JiaoTongVC.h
//  CYCS
//
//  Created by Horus on 16/8/27.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JiaoTongVC : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *qishi;
@property (strong, nonatomic) IBOutlet UITextField *zhongdian;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segement;
@property(nonatomic,retain) CLLocationManager *locationManager;

@end
