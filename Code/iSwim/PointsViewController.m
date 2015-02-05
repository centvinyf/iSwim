//
//  PointsViewController.m
//  iSwim
//
//  Created by Magic Beans on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "PointsViewController.h"
#import "Header.h"
@interface PointsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mStartBtn;
@property (weak, nonatomic) IBOutlet UIButton *mEndBtn;
@property (weak, nonatomic) IBOutlet UIView *mCoverView;
@property (weak, nonatomic) IBOutlet UIDatePicker *mDatePicker;

@end

@implementation PointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mDatePicker.maximumDate=[NSDate date];
    _mDatePicker.hidden=YES;
    [HttpJsonManager getWithParameters:nil sender:self url:[NSString stringWithFormat:@"%@/api/client/profile/points",SERVERADDRESS] completionHandler:^(BOOL sucess, id content) {
        NSLog(@"%s---%@",__FUNCTION__,content);
    }];
    NSLog(@"??");
}
- (IBAction)btnClick:(UIButton *)sender {
    _mDatePicker.hidden=NO;
    [_mDatePicker date];
}
- (IBAction)coverViewCancelBtnClick:(id)sender {
    _mCoverView.hidden=YES;
}
- (IBAction)coverViewSureBtnClick:(id)sender {
    _mCoverView.hidden=YES;
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
