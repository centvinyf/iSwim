//
//  ScoreDetailViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "ScoreDetailViewController.h"
#import "ThisBestHeadTableViewCell.h"
#import "ThisBestDetailTableViewCell.h"
@interface ScoreDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (assign,nonatomic) NSInteger mNumberOfDetail;
@end

@implementation ScoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";
    self.navigationItem.backBarButtonItem = vReturnButtonItem;
    self.mNumberOfDetail = 9;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mNumberOfDetail;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        static NSString *vIdentifiller1 = @"HeadCell";
        ThisBestHeadTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller1];
        if (!vCell) {
            vCell = [[ThisBestHeadTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller1];
        }
        return vCell;
        
    }
    else{
        static NSString * vIdentifiller2 = @"DetailCell";
        ThisBestDetailTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller2];
        if (!vCell) {
            vCell = [[ThisBestDetailTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller2];
        }
        NSArray * vName =[[NSArray alloc]initWithObjects:@"25m",@"50m",@"100m",@"200m",@"400m",@"800m",@"1000m",@"1500m", nil];
        vCell.mName.text = vName[indexPath.row-1];
        
        return vCell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 88;
    }
    else
    {
        return 40;
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
