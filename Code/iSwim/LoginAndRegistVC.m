//
//  LoginAndRegistVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//
#define LOGINED YES

#import "LoginAndRegistVC.h"

@interface LoginAndRegistVC ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@end

@implementation LoginAndRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginBtn.backgroundColor=[UIColor colorWithRed:0xff/255.0 green:0xa0/255.0 blue:0x22/255.0 alpha:1];
    _loginBtn.layer.masksToBounds=YES;
    _loginBtn.layer.cornerRadius=10;
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
- (IBAction)btnClick:(UIButton *)sender {
    if (LOGINED) {
        [self performSegueWithIdentifier:@"PasswordVC" sender:nil];
    }else
    {
#warning ..
        [self presentViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MainVC"] animated:YES completion:nil];
    }
}
- (IBAction)forgetPasswordBtn:(id)sender{
    _coverView.hidden=NO;
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
     
}


@end
