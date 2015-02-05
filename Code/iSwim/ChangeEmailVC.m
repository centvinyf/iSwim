//
//  ChangeEmailVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/2/3.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "ChangeEmailVC.h"
#import "Header.h"
@interface ChangeEmailVC ()
@property (weak, nonatomic) IBOutlet UITextField *mEmailTextField;

@end

@implementation ChangeEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mEmailTextField.text=_mEmail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveBtnClick:(id)sender {
     _block(@{@"email":_mEmailTextField.text});
    [HttpJsonManager postWithParameters:@{@"email":_mEmailTextField.text} sender:self url:[NSString stringWithFormat:@"%@/api/client/profile",SERVERADDRESS] completionHandler:^(BOOL sucess, id content) {
        NSLog(@"%s---%@",__FUNCTION__,content);
    }];
    ALERT(@"保存成功");
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
