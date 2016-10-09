//
//  LoginAndRegester.h
//  CYCS
//
//  Created by Horus on 16/8/16.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBShapedButton.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface LoginAndRegester : UIViewController<UITextFieldDelegate,TencentSessionDelegate>

@property(nonatomic,retain) UITextField *userName;
@property(nonatomic,retain) UITextField *userPW;
@property(nonatomic,retain) UITextField *userName1;
@property(nonatomic,retain) UITextField *userPW1;
@property(nonatomic,retain) UITextField *userCheckPW;
@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) NSURLConnection *connection;
@property(nonatomic,retain) NSURLConnection *connection1;
@property(nonatomic,retain) NSMutableData *receiveData;
@property (nonatomic, retain) TencentOAuth *tencentOAuth;

@end
