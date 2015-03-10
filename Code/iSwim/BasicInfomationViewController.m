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
@property (retain,nonatomic) NSString *mCurrentEventId;
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
    //icon
    [vCell.mImage setImage:[UIImage imageNamed:vPicName1[indexPath.row]] ];
    //titile
    vCell.mTitle.text = vPicName[indexPath.row];
    //value
    switch (indexPath.row) {
        case 0:
            vCell.mData.text = self.mInitData[@"endTime"];
            break;
        case 1:
            vCell.mData.text = [self.mInitData[@"eventId"] stringValue];
            break;
        case 2:
            vCell.mData.text = self.mInitData[@"totalDistance"];
            break;
        case 3:
            vCell.mData.text = self.mInitData[@"totalTime"];
            break;
        case 4:
            vCell.mData.text = self.mInitData[@"totalCalorie"];
            break;
        case 5:
            vCell.mData.text = [self.mInitData[@"numOfSplit"] stringValue];
            break;
        case 6:
            vCell.mData.text = self.mInitData[@"entryTime"];
            break;
        case 7:
            vCell.mData.text = self.mInitData[@"exitTime"];
            break;
        case 8:
            vCell.mData.text = self.mInitData[@"startTime"];
            break;
        case 9:
            vCell.mData.text = self.mInitData[@"end_time"];
            break;
        case 10:
            vCell.mData.text = self.mInitData[@"swimmingPoolName"];
            break;
        default:
            break;
    }

    return vCell;
}
#pragma mark--
- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{@"eventId": self.mCurrentEventId};
    [HttpJsonManager getWithParameters:parameters
                                sender:self url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess) {
             self.mInitData = content;
             [self.mTableView reloadData];
         }
     }];
}

#pragma mark - Navigation
-(void) initWithEventId : (NSString *)EventId
{
    self.mCurrentEventId = EventId;
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
