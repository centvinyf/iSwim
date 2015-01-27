//
//  TrainingEventsViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "TrainingEventsViewController.h"
#import "TrainingEventsTableViewCell.h"
@interface TrainingEventsViewController ()

@end

@implementation TrainingEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiller = @"TrainingEventsTableViewCell";
    TrainingEventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller];
    if (!cell) {
        cell = [[TrainingEventsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: identifiller];
    }
    
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
