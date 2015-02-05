//
//  MainViewController.m
//  iSwim
//
//  Created by Magic Beans on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "MainViewController.h"
#import "MBLineChart.h"
#import "Header.h"
@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mBgImageView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [HttpJsonManager getWithParameters:nil sender:self url:[NSString stringWithFormat:@"%@/api/client/updates",SERVERADDRESS] completionHandler:^(BOOL sucess, id content) {
        _mBgImageView.userInteractionEnabled=YES;
        CGRect rect=CGRectMake(0, 0, _mBgImageView.frame.size.width, _mBgImageView.frame.size.height);
        UIScrollView *chartView = [MBLineChart giveMeAGraphForDictionary:content frame:rect delegate:nil];
        NSLog(@"%@",NSStringFromCGRect(chartView.frame));
        [_mBgImageView addSubview:chartView];
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

- (IBAction)showMyRecord:(id)sender
{
    UIStoryboard *vStoryBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *vMyRecordViewController = [vStoryBoard instantiateViewControllerWithIdentifier:@"MyRecordViewController"];
    [self.navigationController pushViewController:vMyRecordViewController animated:YES];
}

- (IBAction)showTrainingRecords:(id)sender
{
    UIStoryboard *vStoryBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *vMyRecordViewController = [vStoryBoard instantiateViewControllerWithIdentifier:@"TrainingRecordsViewController"];
    [self.navigationController pushViewController:vMyRecordViewController animated:YES];

}

- (IBAction)showPointsDetail:(id)sender
{
    UIStoryboard *vStoryBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *vPointsViewController = [vStoryBoard instantiateViewControllerWithIdentifier:@"PointsViewController"];
    [self.navigationController pushViewController:vPointsViewController animated:YES];
}

- (IBAction)showTrainingEvents:(id)sender
{
    UIStoryboard *vStoryBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *vPointsViewController = [vStoryBoard instantiateViewControllerWithIdentifier:@"TrainingEventsViewController"];
    [self.navigationController pushViewController:vPointsViewController animated:YES];
}

- (IBAction)showTrainingDetail:(id)sender
{
    UIStoryboard *vStoryBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *vMyRecordViewController = [vStoryBoard instantiateViewControllerWithIdentifier:@"TrainingDetailViewController"];
    [self.navigationController pushViewController:vMyRecordViewController animated:YES];
}
@end
