//
//  PasswordVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//
#import "Header.h"
#import "PasswordVC.h"


@interface PasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *mPassword1;
@property (weak, nonatomic) IBOutlet UITextField *mPassword2;

@end

@implementation PasswordVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=NO;
    [_mPassword1 addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_mPassword2 addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [HttpJsonManager getWithParameters:@{@"passwd":[_mPassword1.text MD5]}
                                   url:[NSString stringWithFormat:@"%@/swimming_app/app/client/profile/passwd.do",SERVERADDRESS]
                     completionHandler:^(BOOL sucess, id content) {
        NSLog(@"%d-%@",sucess,content);
    }];
}


@end
