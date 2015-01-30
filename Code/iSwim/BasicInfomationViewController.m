//
//  BasicInfomationViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "BasicInfomationViewController.h"
#import "BasicInfoViewCell.h"
@interface BasicInfomationViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak,nonatomic) NSArray * PicName;
@property (weak, nonatomic) NSArray *TitleName;
@property (weak,nonatomic) NSMutableArray * Data;


@end

@implementation BasicInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @" ";//改改改
    self.navigationItem.backBarButtonItem = returnButtonItem;
    [self initStructure];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initStructure{
    NSArray *PicName = [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"训练距离",@"训练时长",@"热量消耗",@"单边数",@"入场时间",@"离场时间",@"入水时间",@"上岸时间",@"训练场馆", nil];
    self.PicName = PicName;
    self.TitleName=PicName;
    
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *PicName = [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"训练距离",@"训练时长",@"热量消耗",@"单边数",@"入场时间",@"离场时间",@"入水时间",@"上岸时间",@"训练场馆", nil];
    NSArray *PicName1 = [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"训练距离",@"训练时长",@"热量消耗",@"单边数",@"in",@"out",@"in",@"out",@"训练场馆", nil];
    static NSString *identifiller = @"BasicInfoViewCell";
    BasicInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiller];
    if (!cell) {
        cell = [[BasicInfoViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: identifiller];
    }
    [cell.mImage setImage:[UIImage imageNamed:PicName1[indexPath.row]] ];
    
    cell.mTitle.text = PicName[indexPath.row];
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
