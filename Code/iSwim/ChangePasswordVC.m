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
    NSDictionary*vDic=@{@"passwd":[_mPasswordTextField.text MD5]};
    NSLog(@"%@",[_mPasswordTextField.text MD5]);
    [HttpJsonManager getWithParameters:vDic
                                sender:self
                                   url:[NSString stringWithFormat:@"%@/swimming_app/app/client/profile/passwd.do",SERVERADDRESS]
                     completionHandler:^(BOOL sucess, id content)
    {
        NSLog(@"%s---%@",__FUNCTION__,content);
        if (sucess)
        {
            ALERT(@"保存成功");
        }
    }];
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
