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
    BOOL _sex;
}
@property (weak, nonatomic) IBOutlet UIImageView *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *emailView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation NameAndEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameView.layer.masksToBounds=YES;
    _nameView.layer.cornerRadius=5;
//    _nameView.layer.borderColor=[[UIColor grayColor]CGColor];
//    _nameView.layer.borderWidth=1;
    
    _emailView.layer.masksToBounds=YES;
    _emailView.layer.cornerRadius=5;
    //_emailView.layer.borderColor=[[UIColor grayColor]CGColor];
    //_emailView.layer.borderWidth=1;
    
    [_nameTextField addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_emailTextField addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
}
- (IBAction)btnClick:(UIButton *)sender {
    if (!_sex) {
        [sender setBackgroundImage:[UIImage imageNamed:@"女"] forState:UIControlStateNormal];
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"男"] forState:UIControlStateNormal];
    }
    _sex=!_sex;
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
    if ([segue.identifier isEqualToString:@"HeightAndWeightVC"]) {
        NSMutableDictionary*personInfoDic=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personInfoDic"]];
        if (!personInfoDic) {
            personInfoDic=[[NSMutableDictionary alloc]initWithCapacity:0];
        }
        [personInfoDic setObject:_nameTextField.text forKey:@"name"];
        [personInfoDic setObject:_emailTextField.text forKey:@"email"];
        [personInfoDic setObject:[NSNumber numberWithBool:_sex] forKey:@"sex"];
        [[NSUserDefaults standardUserDefaults]setObject:personInfoDic forKey:@"personInfoDic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}


@end
