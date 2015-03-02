//
//  BasicInfomationViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "BasicInfomationViewController.h"
#import "BasicInfoViewCell.h"
#import "HttpJsonManager.h"
@interface BasicInfomationViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak,nonatomic) NSArray * mPicName;
@property (weak, nonatomic) NSArray *mTitleName;
@property (weak,nonatomic) NSMutableArray * mData;
@property (retain,nonatomic) NSDictionary * mInitData;
@end

@implementation BasicInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";
    self.navigationItem.backBarButtonItem = vReturnButtonItem;
    [self initStructure];
    [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/events/info.do"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initStructure{
    NSArray *vPicName = [[NSArray alloc] initWithObjects:@"training_date",@"Training_changci",@"training_distance",@"training_time",@"energy",@"single",@"in",@"out",@"in",@"out",@"place", nil];
    NSArray *vTitleName = [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"训练距离",@"训练时长",@"热量消耗",@"单边数",@"入场时间",@"离场时间",@"入水时间",@"上岸时间",@"训练场馆", nil];
    self.mPicName = vPicName;
    self.mTitleName=vTitleName;
    
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *vPicName = [[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"训练距离",@"训练时长",@"热量消耗",@"单边数",@"入场时间",@"离场时间",@"入水时间",@"上岸时间",@"训练场馆", nil];
    NSArray *vPicName1 = [[NSArray alloc] initWithObjects:@"training_date",@"Training_changci",@"training_distance",@"training_time",@"energy",@"single",@"in",@"out",@"in",@"out",@"place", nil];
    static NSString *vIdentifiller = @"BasicInfoViewCell";
    BasicInfoViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
    if (!vCell) {
        vCell = [[BasicInfoViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: vIdentifiller];
    }
    [vCell.mImage setImage:[UIImage imageNamed:vPicName1[indexPath.row]] ];
    
    vCell.mTitle.text = vPicName[indexPath.row];
    return vCell;
}
#pragma mark--
- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{};
    [HttpJsonManager getWithParameters:parameters
                                sender:self url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess) {
             self.mInitData = content;
             [self initViews:self.mInitData];
             NSLog(@"%@",content);
         }
     }];
}
-(void)initViews: (NSDictionary *)dic
{
    
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
