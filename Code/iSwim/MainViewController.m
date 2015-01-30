//
//  MainViewController.m
//  iSwim
//
//  Created by Magic Beans on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showMyRecord:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *myRecordViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MyRecordViewController"];
    [self.navigationController pushViewController:myRecordViewController animated:YES];
}

- (IBAction)showTrainingRecords:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *myRecordViewController = [storyBoard instantiateViewControllerWithIdentifier:@"TrainingRecordsViewController"];
    [self.navigationController pushViewController:myRecordViewController animated:YES];

}

- (IBAction)showPointsDetail:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *pointsViewController = [storyBoard instantiateViewControllerWithIdentifier:@"PointsViewController"];
    [self.navigationController pushViewController:pointsViewController animated:YES];
}

- (IBAction)showTrainingEvents:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *pointsViewController = [storyBoard instantiateViewControllerWithIdentifier:@"TrainingEventsViewController"];
    [self.navigationController pushViewController:pointsViewController animated:YES];
}

- (IBAction)showTrainingDetail:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *myRecordViewController = [storyBoard instantiateViewControllerWithIdentifier:@"TrainingDetailViewController"];
    [self.navigationController pushViewController:myRecordViewController animated:YES];
}
@end
