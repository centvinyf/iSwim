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

@end

@implementation ScoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.NumberOfDetail = 11;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.NumberOfDetail;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        static NSString *identifiller1 = @"HeadCell";
        ThisBestHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller1];
        if (!cell) {
            cell = [[ThisBestHeadTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: identifiller1];
        }
        return cell;
        
    }
    else{
        static NSString * identifiller2 = @"DetailCell";
        ThisBestDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller2];
        if (!cell) {
            cell = [[ThisBestDetailTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: identifiller2];
        }
        return cell;
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
