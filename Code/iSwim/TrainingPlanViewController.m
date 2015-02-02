//
//  TrainingPlanViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "TrainingPlanViewController.h"
#import "TrainingPlanTableViewCell.h"
#import "TwoLabelTableViewCell.h"
@interface TrainingPlanViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mTabelView;
@end

@implementation TrainingPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";
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
    return 17;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 8||indexPath.row == 0) {
        return 20;
    }
    else
    {
        return 40;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row>=1&&indexPath.row<=7)
    {
        static NSString *vIdentifiller = @"TrainingPlan";
        TrainingPlanTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if (!vCell) {
            vCell = [[TrainingPlanTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        NSArray * vTitle = [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"计划训练距离",@"计划训练时长",@"计划energy",@"计划单边数",@"训练场馆", nil];
        NSArray * vButton= [[NSArray alloc] initWithObjects:@"training_date",@"Training_changci",@"training_distance",@"training_time",@"energy",@"single",@"place", nil];
        [vCell.mImage setImage:[UIImage imageNamed:vButton[indexPath.row-1]]];
        vCell.mTitle.text = vTitle[indexPath.row-1];
        return vCell;

    
    }
    else if(indexPath.row == 8||indexPath.row == 0)
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
    else
    {
        static NSString *vIdentifiller = @"TwoLabel";
        TwoLabelTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if (!vCell) {
            vCell = [[TwoLabelTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        NSArray * vTitle = [[NSArray alloc] initWithObjects:@"25m",@"50m",@"100m",@"200m",@"400m",@"800m",@"1000m",@"1500m", nil];
        
        vCell.mTitle.text = vTitle[indexPath.row-9];
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
