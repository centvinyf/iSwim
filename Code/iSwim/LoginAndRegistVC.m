//
//  LoginAndRegistVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//
#define LOGINED [[HttpJsonManager manager]mToken]
#import "Header.h"
#import "LoginAndRegistVC.h"


@interface LoginAndRegistVC ()

@property (weak, nonatomic) IBOutlet UIButton           *mLoginBtn;
@property (weak, nonatomic) IBOutlet UIView             *mCoverView;
@property (weak, nonatomic) IBOutlet UIButton           *mCoverSureBtn;
@property (weak, nonatomic) IBOutlet UIButton           *mCoverCancelBtn;
@property (weak, nonatomic) IBOutlet UITextField        *mPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField        *mPasswordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mLoginRectTopCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mLogoCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mUserLogoCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTeleCon;
@property (retain,nonatomic) NSDictionary * mForgetSt;
@end

@implementation LoginAndRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mCoverView.hidden = YES;
    
    _mLoginBtn.backgroundColor=[UIColor colorWithRed:0xff/255.0 green:0xa0/255.0 blue:0x22/255.0 alpha:1];
    _mLoginBtn.layer.masksToBounds=YES;
    _mLoginBtn.layer.cornerRadius=10;
    _mLoginBtn.layer.borderWidth=2;
    _mLoginBtn.layer.borderColor=[[UIColor orangeColor]CGColor];
    
    _mCoverCancelBtn.layer.borderWidth=1;
    _mCoverCancelBtn.layer.borderColor=[[UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1] CGColor];
    
    _mCoverSureBtn.layer.borderWidth=1;
    _mCoverSureBtn.layer.borderColor=[[UIColor colorWithRed:0x1a/255.0 green:0x65/255.0 blue:0x94/255.0 alpha:1] CGColor];
    
    [_mPasswordTextField addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([UIScreen mainScreen].bounds.size.height>700)//适配iphone 6 Plus的登陆界面
    {
        self.mLoginRectTopCon.constant+=80;
        self.mUserLogoCon.constant+=80;
        self.mTeleCon.constant +=80;
        self.mLogoCon.constant +=10;
    }
    else if([UIScreen mainScreen].bounds.size.height<500)//适配iphone4 和 4s的登录界面
    {
        self.mLoginRectTopCon.constant -=30;
        self.mUserLogoCon.constant-= 30;
        self.mTeleCon.constant -=30;
    }
     self.navigationController.navigationBarHidden=YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)loadData:(NSObject*)obj
{
    [HttpJsonManager getWithParameters:@{@"phoneNum":_mPhoneNumberTextField.text,@"password":[_mPasswordTextField.text MD5]}
                                   url:[NSString stringWithFormat:@"%@/swimming_app/app/client/authenticate.do",SERVERADDRESS]
                     completionHandler:^(BOOL sucess, id content)
    {
        if ([[content objectForKey:@"id"]length]==0)
        {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入正确的账号和密码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else
        {
            [HttpJsonManager setToken:[content objectForKey:@"id"]];
            NSMutableDictionary*vPersonInfoDic=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personInfoDic"]];
            if (!vPersonInfoDic)
            {
                vPersonInfoDic=[[NSMutableDictionary alloc]initWithCapacity:0];
            }
            [vPersonInfoDic setObject:_mPhoneNumberTextField.text forKey:@"mobilePhone"];
            [[NSUserDefaults standardUserDefaults]setObject:vPersonInfoDic forKey:@"personInfoDic"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            if ([[_mPhoneNumberTextField.text substringFromIndex:5] isEqualToString:_mPasswordTextField.text])
            {
                [self performSegueWithIdentifier:@"PasswordVC" sender:nil];
            }
            else
            {
//                获得个人信息
                [HttpJsonManager getWithParameters:nil
                                               url:[NSString stringWithFormat:@"%@/swimming_app/app/client/profile.do",SERVERADDRESS]
                                 completionHandler:^(BOOL sucess, id content) {
                    [UserProfile manager].mPersonInfo = [[PersonInfoBaseClass alloc]initWithDictionary:content];
                    
                    UIWindow*vWin=[[[UIApplication sharedApplication]delegate] window];
                    vWin.rootViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MainNav"];

                }];
            }
        }
    }];
}

- (IBAction)btnClick:(UIButton *)sender
{   if(_mPhoneNumberTextField)
    [self loadData:nil];
}

- (IBAction)forgetPasswordBtn:(id)sender
{
    if(![self.mPhoneNumberTextField.text isEqualToString:@""])
    {
        _mCoverView.hidden=NO;
    
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                        message:@"请输入手机号码"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (IBAction)coverSureBtnClick:(id)sender
{
    _mCoverView.hidden=YES;
    NSDictionary * Parameters = @{@"mobile":self.mPhoneNumberTextField.text};
    [HttpJsonManager getWithParameters:Parameters
                                   url:@"http://192.168.1.113:8080/swimming_app/app/client/profile/forget.do"
                     completionHandler:^(BOOL sucess, id content) {
                         self.mForgetSt = content;
                         if ([content[@"rs"] isEqualToString:@"01"]) {
                             UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"新密码已发送至您的邮箱" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                             [alert show];
                         }else if([content[@"rs"] isEqualToString:@"02"]){
                             UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"服务器错误，请稍后再试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                             [alert show];
                         }else if([content[@"rs"] isEqualToString:@"03"]){
                             UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                             [alert show];
                         }
                         
    }];
}

- (IBAction)coverCancelBtnClick:(id)sender
{
    _mCoverView.hidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     
}


@end
