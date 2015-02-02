//
//  JifenDetailViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "JifenDetailViewController.h"
#import "JifenTableViewCell.h"
@interface JifenDetailViewController ()

@end

@implementation JifenDetailViewController

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *vIdentifiller = @"JifenTableViewCell";
    JifenTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
    if (!vCell) {
        vCell = [[JifenTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: vIdentifiller];
    }
    
    return vCell;
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
