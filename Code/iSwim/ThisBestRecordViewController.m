//
//  ThisBestRecordViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "ThisBestRecordViewController.h"
#import "ThisBestDetailTableViewCell.h"
#import "ThisBestHeadTableViewCell.h"
@interface ThisBestRecordViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property(weak,nonatomic) NSArray * mName;
@property(weak,nonatomic) NSArray * Score;
@property (weak,nonatomic) NSArray * Begin;
@property (weak,nonatomic) NSArray * End;

@end

@implementation ThisBestRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @" ";//改改改
    self.navigationItem.backBarButtonItem = returnButtonItem;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
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
        NSArray * mName =[[NSArray alloc]initWithObjects:@"25m",@"50m",@"100m",@"200m",@"400m",@"800m",@"1000m",@"1500m", nil];
        cell.mName.text = mName[indexPath.row-1];
        
        return cell;
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
