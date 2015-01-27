//
//  LoginAndRegistVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "LoginAndRegistVC.h"

@interface LoginAndRegistVC ()
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginAndRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _registBtn.backgroundColor=[UIColor colorWithRed:0xff/255.0 green:0xa0/255.0 blue:0x22/255.0 alpha:1];
    _loginBtn.backgroundColor=[UIColor colorWithRed:0xff/255.0 green:0xa0/255.0 blue:0x22/255.0 alpha:1];
    _registBtn.layer.masksToBounds=YES;
    _registBtn.layer.cornerRadius=10;
    _loginBtn.layer.masksToBounds=YES;
    _loginBtn.layer.cornerRadius=10;
    _registBtn.layer.borderWidth=2;
    _registBtn.layer.borderColor=[[UIColor orangeColor]CGColor];
    _loginBtn.layer.borderWidth=2;
    _loginBtn.layer.borderColor=[[UIColor orangeColor]CGColor];
}
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden=YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     self.navigationController.navigationBarHidden=NO;
}


@end
