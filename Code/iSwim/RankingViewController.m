//
//  RankingViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/28.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "RankingViewController.h"
#import "TrainingPlanTableViewCell.h"
#import "TwoLabelTableViewCell.h"
#import "PaimingTableViewCell.h"
#import "ThreeLabelTableViewCell.h"
@interface RankingViewController ()

@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";//改改改
    self.navigationItem.backBarButtonItem = vReturnButtonItem;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7||indexPath.row == 0) {
        return 20;
    }
    else
    {
        return 40;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * vTitle = [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"本场距离排名",@"本场时长排名",@"本场消耗排名",@"训练场馆", nil];
    NSArray * vButton= [[NSArray alloc] initWithObjects:@"training_date",@"Training_changci",@"training_distance",@"training_time",@"energy",@"place", nil];
    
    if(indexPath.row==1||indexPath.row ==2||indexPath.row == 6)//直接显示
    {
        static NSString *vIdentifiller = @"TrainingPlan";
        TrainingPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if (!cell) {
            cell = [[TrainingPlanTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        
        [cell.mImage setImage:[UIImage imageNamed:vButton[indexPath.row-1]]];
        cell.mTitle.text = vTitle[indexPath.row-1];
        return cell;
        
        
    }
    else if(indexPath.row>=3&&indexPath.row<=5)//有排名
    {
        static NSString *vIdentifiller = @"TrainingPlan";
        PaimingTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if (!vCell) {
            vCell = [[PaimingTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        
        [vCell.mImage setImage:[UIImage imageNamed:vButton[indexPath.row-1]]];
        vCell.mTitle.text = vTitle[indexPath.row-1];
        return vCell;

    
    }
    else if(indexPath.row == 7||indexPath.row == 0)//灰条
    {
        static NSString * vIdentifiller = @"gray";
        UITableViewCell * vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if(!vCell){
            vCell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        return  vCell;
        
    }
    else//分项排名
    {
        static NSString *vIdentifiller = @"ThreeLabel";
        ThreeLabelTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if (!vCell) {
            vCell = [[ThreeLabelTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        NSArray * vTitle = [[NSArray alloc] initWithObjects:@"25m",@"50m",@"100m",@"200m",@"400m",@"800m",@"1000m",@"1500m", nil];
        
        vCell.mTitle.text = vTitle[indexPath.row-8];
        return vCell;
        
    }
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
