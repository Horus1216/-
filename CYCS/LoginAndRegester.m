//
//  LoginAndRegester.m
//  CYCS
//
//  Created by Horus on 16/8/16.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import "LoginAndRegester.h"
#import "ViewController.h"
#import "WeiboSDK.h"

@interface LoginAndRegester ()
{
    NSString *uiDeviceID;
    BOOL isCheckedBox;
}

@end

@implementation LoginAndRegester

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    uiDeviceID=[[UIDevice currentDevice].identifierForVendor.UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    UIImageView *backImage=[[UIImageView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width*2, 0, self.view.frame.size.width*3, self.view.frame.size.height)];
    backImage.tag=601;
    backImage.image=[UIImage imageNamed:@"loginBK"];
    backImage.alpha=0.6;
    [self.view addSubview:backImage];
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.bounces=YES;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width*2, self.view.bounds.size.height);
    self.scrollView.scrollEnabled=NO;
    [self.view addSubview:self.scrollView];
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(30, 55, self.view.bounds.size.width-60, self.view.bounds.size.height-60)];
    scrollView.bounces=YES;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.contentSize=CGSizeMake(self.view.bounds.size.width-60, self.view.bounds.size.height);
    [self.scrollView addSubview:scrollView];
    
    UILabel *userTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    userTitle.text=@"用户名";
    userTitle.textColor=[UIColor whiteColor];
    userTitle.font=[UIFont systemFontOfSize:15];
    [scrollView addSubview:userTitle];
    
    self.userName=[[UITextField alloc]initWithFrame:CGRectMake(userTitle.frame.origin.x, userTitle.frame.origin.y+25, self.view.bounds.size.width-60, 25)];
    self.userName.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"输入用户名" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.userName.textColor=[UIColor whiteColor];
    self.userName.font=[UIFont systemFontOfSize:15];
    self.userName.delegate=self;
    [scrollView addSubview:self.userName];
    
    UIImageView *line1=[[UIImageView alloc]initWithFrame:CGRectMake(self.userName.frame.origin.x, self.userName.frame.origin.y+27, self.view.bounds.size.width-60, 1)];
    line1.image=[UIImage imageNamed:@"cell_bg"];
    [scrollView addSubview:line1];
    
    UILabel *PWTitle=[[UILabel alloc]initWithFrame:CGRectMake(self.userName.frame.origin.x, self.userName.frame.origin.y+50, 60, 20)];
    PWTitle.text=@"密码";
    PWTitle.textColor=[UIColor whiteColor];
    PWTitle.font=[UIFont systemFontOfSize:15];
    [scrollView addSubview:PWTitle];
    
    self.userPW=[[UITextField alloc]initWithFrame:CGRectMake(PWTitle.frame.origin.x, PWTitle.frame.origin.y+25, self.view.bounds.size.width-60, 25)];
    self.userPW.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.userPW.textColor=[UIColor whiteColor];
    self.userPW.font=[UIFont systemFontOfSize:15];
    self.userPW.delegate=self;
    [scrollView addSubview:self.userPW];
    
    UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(self.userPW.frame.origin.x, self.userPW.frame.origin.y+27, self.view.bounds.size.width-60, 1)];
    line2.image=[UIImage imageNamed:@"cell_bg"];
    [scrollView addSubview:line2];
    
    UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame=CGRectMake(PWTitle.frame.origin.x, self.userPW.frame.origin.y+60, self.view.bounds.size.width-60, 40);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"导航栏"] forState:UIControlStateNormal];
    loginButton.layer.cornerRadius=10.0;
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.masksToBounds=YES;
    [scrollView addSubview:loginButton];
    
    UIButton *zjfwButton=[UIButton buttonWithType:UIButtonTypeCustom];
    zjfwButton.frame=CGRectMake(loginButton.frame.origin.x, loginButton.frame.origin.y+80, 70, 20);
    [zjfwButton setTitle:@"直接访问" forState:UIControlStateNormal];
    [zjfwButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zjfwButton.titleLabel.font=[UIFont systemFontOfSize:15];
    zjfwButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [zjfwButton setBackgroundColor:[UIColor clearColor]];
    [zjfwButton addTarget:self action:@selector(zjfwButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:zjfwButton];
    
    UIImageView *line3=[[UIImageView alloc]initWithFrame:CGRectMake(zjfwButton.frame.origin.x, zjfwButton.frame.origin.y+21, zjfwButton.bounds.size.width, 1)];
    line3.image=[UIImage imageNamed:@"cell_bg"];
    [scrollView addSubview:line3];
    
    UIButton *kszcButton=[UIButton buttonWithType:UIButtonTypeCustom];
    kszcButton.frame=CGRectMake(loginButton.frame.origin.x+loginButton.frame.size.width-80, loginButton.frame.origin.y+80, 80, 20);
    [kszcButton setTitle:@"快速注册>" forState:UIControlStateNormal];
    [kszcButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    kszcButton.titleLabel.font=[UIFont systemFontOfSize:15];
    kszcButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [kszcButton addTarget:self action:@selector(kszcButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [kszcButton setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:kszcButton];
    
    UIImageView *line4=[[UIImageView alloc]initWithFrame:CGRectMake(kszcButton.frame.origin.x, kszcButton.frame.origin.y+21, kszcButton.bounds.size.width, 1)];
    line4.image=[UIImage imageNamed:@"cell_bg"];
    [scrollView addSubview:line4];
    
    UIImageView *line5=[[UIImageView alloc]initWithFrame:CGRectMake(line3.frame.origin.x, line3.frame.origin.y+40, (loginButton.bounds.size.width-20)/2, 1)];
    line5.image=[UIImage imageNamed:@"cell_bg"];
    [scrollView addSubview:line5];
    
    UILabel *labelConnect=[[UILabel alloc]initWithFrame:CGRectMake(line5.frame.origin.x+line5.frame.size.width+5, line5.frame.origin.y-5, 10, 10)];
    labelConnect.font=[UIFont systemFontOfSize:10];
    labelConnect.text=@"或";
    labelConnect.textColor=[UIColor whiteColor];
    [scrollView addSubview:labelConnect];
    
    UIImageView *line6=[[UIImageView alloc]initWithFrame:CGRectMake(labelConnect.frame.origin.x+labelConnect.frame.size.width+5,line5.frame.origin.y ,(loginButton.bounds.size.width-20)/2,1)];
    line6.image=[UIImage imageNamed:@"cell_bg"];
    [scrollView addSubview:line6];
    
    OBShapedButton *qqLogin=[OBShapedButton buttonWithType:UIButtonTypeCustom];
    [qqLogin setBackgroundImage:[UIImage imageNamed:@"login_third_qq_icon"] forState:UIControlStateNormal];
    qqLogin.frame=CGRectMake(0, 0, 40, 40);
    qqLogin.center=CGPointMake(line5.frame.origin.x+line5.frame.size.width/2, line5.frame.origin.y+35);
    [qqLogin addTarget:self action:@selector(qqLogining) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:qqLogin];
    
    OBShapedButton *weiboLogin=[OBShapedButton buttonWithType:UIButtonTypeCustom];
    [weiboLogin setBackgroundImage:[UIImage imageNamed:@"login_third_weibo_icon"] forState:UIControlStateNormal];
    weiboLogin.frame=CGRectMake(0, 0, 40, 40);
    [weiboLogin addTarget:self action:@selector(sinaloging) forControlEvents:UIControlEventTouchUpInside];
    weiboLogin.center=CGPointMake(line6.frame.origin.x+line6.frame.size.width/2, line6.frame.origin.y+35);
    [scrollView addSubview:weiboLogin];
    
    [self scrollView2];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(backImageScroll) userInfo:nil repeats:YES];

    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(releaseFirstResponder)];
    [self.scrollView addGestureRecognizer:tapGesture];
    
    BOOL noDirectory=NO;
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *AutoLogingRequired=[NSString stringWithFormat:@"%@/AutoLogingRequired.tag",library];
    NSString *loginInfo=[NSString stringWithFormat:@"%@/loginInfo.plist",library];
    NSString *OnceTag=[NSString stringWithFormat:@"%@/Once.tag",library];
    if ([manager fileExistsAtPath:AutoLogingRequired isDirectory:&noDirectory]&&[manager fileExistsAtPath:loginInfo isDirectory:&noDirectory]) {
        NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:loginInfo];
        if ([manager fileExistsAtPath:OnceTag isDirectory:&noDirectory]) {
            
        }
        else
        {
            self.userName.text=[dic objectForKey:@"Name"];
            self.userPW.text=[dic objectForKey:@"PW"];
            [self loginButtonClicked];
        }
    }
}

-(void)qqLogining
{
    [self QQLogout];//先登出
    
    //获取本地保存的授权信息
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    NSString *openId = [[NSUserDefaults standardUserDefaults] objectForKey:@"openId"];
    NSDate *expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"expirationDate"];
    
    //创建QQ授权对象
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1105158435" andDelegate:self];
    NSArray *permissions = @[@"get_user_info",@"get_simple_userinfo",@"add_t"];
    if (accessToken && openId && expirationDate) {
        NSDate *currentDate = [NSDate date];
        if ([currentDate compare:expirationDate] > 0) {//当前日期大于过期时间，重新登录
            [self.tencentOAuth authorize:permissions inSafari:NO];
        } else {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }
    else {
        [self.tencentOAuth authorize:permissions inSafari:NO];
    }
}

-(void)QQLogout
{
    [self.tencentOAuth logout:self];
    
    //清除本地保存的授权信息
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"openId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"expirationDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)sinaloging
{
    //先判断本地是否存在accessToken，是否过期了
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"sinaToken"];
    NSInteger expires_in = [[NSUserDefaults standardUserDefaults] integerForKey:@"sinaExpires"];
    float startSaveTimer = [[NSUserDefaults standardUserDefaults] floatForKey:@"sinaSaveTimer"];//获取保存信息时的时间
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];//获取当前最新时间
    NSTimeInterval chazhi = interval-startSaveTimer;
    if (access_token && chazhi < expires_in) { //存在accessToken并且没过期
        NSLog(@"可以直接进入主界面了");
    }else { //开始授权登录
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
        request.scope = @"all";
        request.userInfo = @{@"SSO_From":@"SendMessageToWeiboViewController",
                             @"Other_Info_1":[NSNumber numberWithInt:123],
                             @"Other_Info_2":@[@"obj1",@"obj2"],
                             @"Other_Info_3":@{@"key1":@"obj1",@"key2":@"obj2"}};
        [WeiboSDK sendRequest:request];
    }
}


-(void)loginButtonClicked
{
    if ([self isValide]) {
    NSString *loginJson=[NSString stringWithFormat:@"p={\"a\":\"%@\",\"b\":\"0\",\"c\":\"%@\",\"d\":\"%@\",\"key\":\"123456789\"}",uiDeviceID,self.userName.text,self.userPW.text];
    NSString *urlString=@"http://112.74.108.147:6300/MixcAPI/login";
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (self.connection) {
        [self.connection cancel];
        self.connection=nil;
    }
    if (!self.receiveData) {
        self.receiveData=[NSMutableData data];
    }
    else
    {
        [self.receiveData setLength:0];
    }
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[loginJson dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    self.connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    [self.connection start];
    }
    [self.userName resignFirstResponder];
    [self.userPW resignFirstResponder];
}

-(void)scrollView2
{
    UIScrollView *scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(30+self.view.bounds.size.width, 55, self.view.bounds.size.width-60, self.view.bounds.size.height-60)];
    scrollView2.bounces=YES;
    scrollView2.showsVerticalScrollIndicator=NO;
    scrollView2.contentSize=CGSizeMake(self.view.bounds.size.width-60, self.view.bounds.size.height);
    [self.scrollView addSubview:scrollView2];
    
    UILabel *userTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    userTitle.text=@"用户名";
    userTitle.textColor=[UIColor whiteColor];
    userTitle.font=[UIFont systemFontOfSize:15];
    [scrollView2 addSubview:userTitle];
    
    self.userName1=[[UITextField alloc]initWithFrame:CGRectMake(userTitle.frame.origin.x, userTitle.frame.origin.y+25, self.view.bounds.size.width-60, 25)];
    self.userName1.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"输入用户名" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.userName1.textColor=[UIColor whiteColor];
    self.userName1.font=[UIFont systemFontOfSize:15];
    self.userName1.delegate=self;
    [scrollView2 addSubview:self.userName1];
    
    UIImageView *line1=[[UIImageView alloc]initWithFrame:CGRectMake(self.userName1.frame.origin.x, self.userName1.frame.origin.y+27, self.view.bounds.size.width-60, 1)];
    line1.image=[UIImage imageNamed:@"cell_bg"];
    [scrollView2 addSubview:line1];
    
    UILabel *PWTitle=[[UILabel alloc]initWithFrame:CGRectMake(self.userName1.frame.origin.x, self.userName1.frame.origin.y+50, 60, 20)];
    PWTitle.text=@"密码";
    PWTitle.textColor=[UIColor whiteColor];
    PWTitle.font=[UIFont systemFontOfSize:15];
    [scrollView2 addSubview:PWTitle];
    
    self.userPW1=[[UITextField alloc]initWithFrame:CGRectMake(PWTitle.frame.origin.x, PWTitle.frame.origin.y+25, self.view.bounds.size.width-60, 25)];
    self.userPW1.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.userPW1.textColor=[UIColor whiteColor];
    self.userPW1.font=[UIFont systemFontOfSize:15];
    self.userPW1.delegate=self;
    [scrollView2 addSubview:self.userPW1];
    
    UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(self.userPW1.frame.origin.x, self.userPW1.frame.origin.y+27, self.view.bounds.size.width-60, 1)];
    line2.image=[UIImage imageNamed:@"cell_bg"];
    [scrollView2 addSubview:line2];
    
    UILabel *PWCheckTitle=[[UILabel alloc]initWithFrame:CGRectMake(self.userPW1.frame.origin.x, self.userPW1.frame.origin.y+50, 60, 20)];
    PWCheckTitle.text=@"确认密码";
    PWCheckTitle.textColor=[UIColor whiteColor];
    PWCheckTitle.font=[UIFont systemFontOfSize:15];
    [scrollView2 addSubview:PWCheckTitle];
    
    self.userCheckPW=[[UITextField alloc]initWithFrame:CGRectMake(PWCheckTitle.frame.origin.x, PWCheckTitle.frame.origin.y+25, self.view.bounds.size.width-60, 25)];
    self.userCheckPW.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"确认密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.userCheckPW.textColor=[UIColor whiteColor];
    self.userCheckPW.font=[UIFont systemFontOfSize:15];
    self.userCheckPW.delegate=self;
    [scrollView2 addSubview:self.userCheckPW];
    
    UIImageView *line3=[[UIImageView alloc]initWithFrame:CGRectMake(self.userCheckPW.frame.origin.x, self.userCheckPW.frame.origin.y+27, self.view.bounds.size.width-60, 1)];
    line3.image=[UIImage imageNamed:@"cell_bg"];
    [scrollView2 addSubview:line3];
    
    UILabel *checkBoxInfo=[[UILabel alloc]initWithFrame:CGRectMake(scrollView2.bounds.size.width-70, self.userCheckPW.frame.origin.y+self.userCheckPW.frame.size.height+10, 75, 20)];
    checkBoxInfo.font=[UIFont systemFontOfSize:15];
    checkBoxInfo.textColor=[UIColor whiteColor];
    checkBoxInfo.text=@"自动登录?";
    [scrollView2 addSubview:checkBoxInfo];
    
    UIButton *checkButton=[UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.frame=CGRectMake(checkBoxInfo.frame.origin.x-20, checkBoxInfo.frame.origin.y, 20, 20);
    BOOL noDirectory=NO;
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *AutoLogingRequired=[NSString stringWithFormat:@"%@/AutoLogingRequired.tag",library];
    if ([manager fileExistsAtPath:AutoLogingRequired isDirectory:&noDirectory]) {
        [checkButton setBackgroundImage:[UIImage imageNamed:@"复选框_选中"] forState:UIControlStateNormal];
        isCheckedBox=YES;
    }
    else
    {
        [checkButton setBackgroundImage:[UIImage imageNamed:@"复选框_默认"] forState:UIControlStateNormal];
        isCheckedBox=NO;
    }
    [checkButton addTarget:self action:@selector(checkBoxAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView2 addSubview:checkButton];
    
    UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame=CGRectMake(PWTitle.frame.origin.x, self.userCheckPW.frame.origin.y+80, self.view.bounds.size.width-60, 40);
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"导航栏"] forState:UIControlStateNormal];
    loginButton.layer.cornerRadius=10.0;
    [loginButton addTarget:self action:@selector(regesterButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.masksToBounds=YES;
    [scrollView2 addSubview:loginButton];
    
    UIButton *kszcButton=[UIButton buttonWithType:UIButtonTypeCustom];
    kszcButton.frame=CGRectMake(loginButton.frame.origin.x+loginButton.frame.size.width-90, loginButton.frame.origin.y+80, 90, 20);
    [kszcButton setTitle:@"已有账号,马上登录" forState:UIControlStateNormal];
    [kszcButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    kszcButton.titleLabel.font=[UIFont systemFontOfSize:10];
    kszcButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [kszcButton addTarget:self action:@selector(loginBack) forControlEvents:UIControlEventTouchUpInside];
    [kszcButton setBackgroundColor:[UIColor clearColor]];
    [scrollView2 addSubview:kszcButton];
    
    UIImageView *line4=[[UIImageView alloc]initWithFrame:CGRectMake(kszcButton.frame.origin.x, kszcButton.frame.origin.y+21, kszcButton.bounds.size.width, 1)];
    line4.image=[UIImage imageNamed:@"cell_bg"];
    [scrollView2 addSubview:line4];
}

-(void)regesterButtonClicked
{
    if (![self.userPW1.text isEqualToString:self.userCheckPW.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"输入密码与确认密码不同" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alert show];
        return;
    }
    if ([self isValide1]) {
        NSString *loginJson=[NSString stringWithFormat:@"p={\"a\":\"%@\",\"b\":\"0\",\"c\":\"%@\",\"d\":\"%@\",\"key\":\"123456789\"}",uiDeviceID,self.userName1.text,self.userPW1.text];
        NSString *urlString=@"http://112.74.108.147:6300/MixcAPI/regist";
        NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        if (self.connection1) {
            [self.connection1 cancel];
            self.connection1=nil;
        }
        if (!self.receiveData) {
            self.receiveData=[NSMutableData data];
        }
        else
        {
            [self.receiveData setLength:0];
        }
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[loginJson dataUsingEncoding:NSUTF8StringEncoding]];
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        self.connection1=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
        [self.connection1 start];
    }
    [self.userName1 resignFirstResponder];
    [self.userPW1 resignFirstResponder];
    [self.userCheckPW resignFirstResponder];
}

-(void)loginBack
{
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset=CGPointMake(0, 0);
    }];
}

-(void)checkBoxAction:(UIButton *)button
{
    BOOL noDirectory=NO;
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *AutoLogingRequired=[NSString stringWithFormat:@"%@/AutoLogingRequired.tag",library];
    NSString *AutoLogingNotRequired=[NSString stringWithFormat:@"%@/AutoLogingNotRequired.tag",library];

    if (isCheckedBox==YES) {
        [button setBackgroundImage:[UIImage imageNamed:@"复选框_默认"] forState:UIControlStateNormal];
        if ([manager fileExistsAtPath:AutoLogingRequired isDirectory:&noDirectory]) {
            [manager removeItemAtPath:AutoLogingRequired error:nil];
            [manager createFileAtPath:AutoLogingNotRequired contents:nil attributes:nil];
        }
        isCheckedBox=NO;
    }
    else
    {
        if ([manager fileExistsAtPath:AutoLogingNotRequired isDirectory:&noDirectory]) {
            [manager removeItemAtPath:AutoLogingNotRequired error:nil];
            [manager createFileAtPath:AutoLogingRequired contents:nil attributes:nil];
        }
        [button setBackgroundImage:[UIImage imageNamed:@"复选框_选中"] forState:UIControlStateNormal];
        isCheckedBox=YES;
    }
}

-(void)releaseFirstResponder
{
    [self.userName resignFirstResponder];
    [self.userPW resignFirstResponder];
    [self.userName1 resignFirstResponder];
    [self.userPW1 resignFirstResponder];
    [self.userCheckPW resignFirstResponder];
}

-(void)backImageScroll
{
    UIImageView *image=[self.view viewWithTag:601];
    image.transform=CGAffineTransformTranslate(image.transform, 1, 0);
    if (image.frame.origin.x==0) {
        image.frame=CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width*2, self.view.frame.size.height);
    }
}

-(void)zjfwButtonClicked
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    UINavigationController *nvg=[[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
    [UIApplication sharedApplication].keyWindow.rootViewController=nvg;
}

-(void)kszcButtonClicked
{
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset=CGPointMake(self.view.bounds.size.width, 0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.receiveData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receiveData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection==self.connection) {
        
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:self.receiveData
                                                    options:NSJSONReadingMutableLeaves
                                                      error:nil];
        int result=[[object objectForKey:@"j"] intValue];
        if (result==0) {

            BOOL noDirectory=NO;
            NSFileManager *manager=[NSFileManager defaultManager];
            NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *Loginned=[NSString stringWithFormat:@"%@/Loginned.tag",library];
            NSString *notLoginned=[NSString stringWithFormat:@"%@/notLoginned.tag",library];
            NSString *OnceTag=[NSString stringWithFormat:@"%@/Once.tag",library];
            if ([manager fileExistsAtPath:OnceTag isDirectory:&noDirectory]) {
                [manager removeItemAtPath:OnceTag error:nil];
            }
            if ([manager fileExistsAtPath:Loginned isDirectory:&noDirectory]) {
                
            }
            else
            {
                [manager removeItemAtPath:notLoginned error:nil];
                [manager createFileAtPath:Loginned contents:nil attributes:nil];
            }
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }
    });
    }
    if (connection==self.connection1) {
        
        
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:self.receiveData
                                                                   options:NSJSONReadingMutableLeaves
                                                                     error:nil];
            int result=[[object objectForKey:@"j"] intValue];
            switch (result) {
                case 0:
                {
                    self.userName=self.userName1;
                    self.userPW=self.userPW1;
                    [self loginButtonClicked];
                }
                    break;
                case 1:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"注册失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                    [alert show];
                }
                    break;
                case 2:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"账号已存在" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                    [alert show];
                }
                    break;
                    
                default:
                    break;
            }
       
    }
    BOOL noDirectory=NO;
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *library=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *loginInfo=[NSString stringWithFormat:@"%@/loginInfo.plist",library];
    if (![manager fileExistsAtPath:loginInfo isDirectory:&noDirectory]) {
        [manager createFileAtPath:loginInfo contents:nil attributes:nil];
    }
    NSDictionary *loginInfoDic=@{@"ID":uiDeviceID,@"Name":self.userName.text,@"PW":self.userPW.text};
    [loginInfoDic writeToFile:loginInfo atomically:YES];
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.connection cancel];
    NSLog(@"Error:%@", [error localizedDescription]);
}

- (BOOL)isValide {
    NSString *nameRegex = @"^[A-Za-z]{6,12}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nameRegex];
    if (![test evaluateWithObject:self.userName.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"用户名只能由6～12位字母组成" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alert show];
        return NO;
    }
    
    NSString *secretRegex = @"^\\d{6}$";
    NSPredicate *test2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",secretRegex];
    if (![test2 evaluateWithObject:self.userPW.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码只能由6位数字组成" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alert show];
        return NO;
    }
    
    return YES;
}

- (BOOL)isValide1 {
    NSString *nameRegex = @"^[A-Za-z]{6,12}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nameRegex];
    if (![test evaluateWithObject:self.userName1.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"用户名只能由6～12位字母组成" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alert show];
        return NO;
    }
    
    NSString *secretRegex = @"^\\d{6}$";
    NSPredicate *test2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",secretRegex];
    if (![test2 evaluateWithObject:self.userPW1.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码只能由6位数字组成" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alert show];
        return NO;
    }
    
    return YES;
}

@end
