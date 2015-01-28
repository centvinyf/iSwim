//
//  TrainingPlanViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "TrainingPlanViewController.h"
#import "TrainingPlanTableViewCell.h"
@interface TrainingPlanViewController ()

@end

@implementation TrainingPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiller = @"TrainingPlan";
    TrainingPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller];
    if (!cell) {
        cell = [[TrainingPlanTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: identifiller];
    }
    NSArray * Title = [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"计划训练距离",@"计划训练时长",@"计划热量消耗",@"计划单边数",@"训练场馆", nil];
    NSArray * button= [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"训练距离",@"训练时长",@"热量消耗",@"单边数",@"训练场馆", nil];
    [cell.mImage setImage:[UIImage imageNamed:button[indexPath.row]]];
    cell.mTitle.text = Title[indexPath.row];
    return cell;
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
