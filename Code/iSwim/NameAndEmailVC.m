//
//  NameAndEmailVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "NameAndEmailVC.h"

@interface NameAndEmailVC ()
{
    BOOL _mSex;
}
@property (weak, nonatomic) IBOutlet UIImageView *mNameView;
@property (weak, nonatomic) IBOutlet UIImageView *mEmailView;
@property (weak, nonatomic) IBOutlet UITextField *mNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mEmailTextField;

@end

@implementation NameAndEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _mNameView.layer.masksToBounds=YES;
    _mNameView.layer.cornerRadius=5;
//    _nameView.layer.borderColor=[[UIColor grayColor]CGColor];
//    _nameView.layer.borderWidth=1;
    
    _mEmailView.layer.masksToBounds=YES;
    _mEmailView.layer.cornerRadius=5;
    //_emailView.layer.borderColor=[[UIColor grayColor]CGColor];
    //_emailView.layer.borderWidth=1;
    
    [_mNameTextField addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_mEmailTextField addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    _mEmailTextField.autocorrectionType=UITextAutocorrectionTypeNo;
}
- (IBAction)btnClick:(UIButton *)sender {
    if (!_mSex) {
        [sender setBackgroundImage:[UIImage imageNamed:@"女"] forState:UIControlStateNormal];
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"男"] forState:UIControlStateNormal];
    }
    _mSex=!_mSex;
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // save name,sex,email
    NSLog(@"%s\n%@",__FUNCTION__,segue.identifier);
    if ([segue.identifier isEqualToString:@"HeightAndWeightVC"]) {
        NSMutableDictionary*vPersonInfoDic=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personInfoDic"]];
        if (!vPersonInfoDic) {
            vPersonInfoDic=[[NSMutableDictionary alloc]initWithCapacity:0];
        }
        [vPersonInfoDic setObject:_mNameTextField.text forKey:@"name"];
        [vPersonInfoDic setObject:_mEmailTextField.text forKey:@"email"];
        [vPersonInfoDic setObject:[NSNumber numberWithBool:_mSex] forKey:@"sex"];
        [[NSUserDefaults standardUserDefaults]setObject:vPersonInfoDic forKey:@"personInfoDic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}


@end
