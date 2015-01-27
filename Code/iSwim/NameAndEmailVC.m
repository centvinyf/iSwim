//
//  NameAndEmailVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "NameAndEmailVC.h"

@interface NameAndEmailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *emailView;
@property (weak, nonatomic) IBOutlet UIView *sexBgView;
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
    
//    _sexBgView.layer.masksToBounds=YES;
//    _sexBgView.layer.cornerRadius=15;
//    _sexBgView.layer.borderColor=[[UIColor cyanColor]CGColor];
//    _sexBgView.layer.borderWidth=1;
    [_nameTextField addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_emailTextField addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
