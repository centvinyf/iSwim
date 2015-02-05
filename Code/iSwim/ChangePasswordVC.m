//
//  ChangePasswordVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/2/3.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "Header.h"
@interface ChangePasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *mPasswordTextField;

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveBtnClick:(id)sender
{
    NSDictionary*vDic=@{@"password":_mPasswordTextField.text,@"passwordConfirmed":_mPasswordTextField.text};
    [HttpJsonManager postWithParameters:vDic sender:self url:[NSString stringWithFormat:@"%@/api/client/profile/password",SERVERADDRESS] completionHandler:^(BOOL sucess, id content) {
        NSLog(@"%s---%@",__FUNCTION__,content);
    }];
    ALERT(@"修改成功");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
