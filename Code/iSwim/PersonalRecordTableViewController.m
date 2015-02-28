//
//  PersonalRecordTableViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/2/3.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "PersonalRecordTableViewController.h"
#import "HttpJsonManager.h"
@interface PersonalRecordTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mCaluli;
@property (weak, nonatomic) IBOutlet UILabel *mSwimmingPoolName;
@property (weak, nonatomic) IBOutlet UILabel *mUserGrade;
@property (weak, nonatomic) IBOutlet UILabel *mUserId;
@property (weak, nonatomic) IBOutlet UILabel *mTotalDistance;
@property (weak, nonatomic) IBOutlet UILabel *mTotalSwimmingTime;
@property (weak, nonatomic) IBOutlet UILabel *mTotalCaluli;
@property (weak, nonatomic) IBOutlet UILabel *mLongestEventDis;
@property (weak, nonatomic) IBOutlet UILabel *mLongestEventDate;
@property (weak, nonatomic) IBOutlet UILabel *mLongestEventPlace;
@property (weak, nonatomic) IBOutlet UILabel *mLongestTimeTimt;
@property (weak, nonatomic) IBOutlet UILabel *mLongestTimeDate;
@property (weak, nonatomic) IBOutlet UILabel *mLongestTimePlace;
@property (weak, nonatomic) IBOutlet UILabel *mBigestCalCal;
@property (weak, nonatomic) IBOutlet UILabel *mBigestCalDate;
@property (weak, nonatomic) IBOutlet UILabel *mBigestCalPlace;
@property (weak, nonatomic) IBOutlet UILabel *m25BestTime;
@property (weak, nonatomic) IBOutlet UILabel *m25Date;
@property (weak, nonatomic) IBOutlet UILabel *m50BestTime;
@property (weak, nonatomic) IBOutlet UILabel *m50Date;
@property (weak, nonatomic) IBOutlet UILabel *m100BestTime;
@property (weak, nonatomic) IBOutlet UILabel *m100Date;
@property (weak, nonatomic) IBOutlet UILabel *m200BestTime;
@property (weak, nonatomic) IBOutlet UILabel *m200Date;
@property (weak, nonatomic) IBOutlet UILabel *m400BestTime;
@property (weak, nonatomic) IBOutlet UILabel *m400Date;
@property (weak, nonatomic) IBOutlet UILabel *m800BestTime;
@property (weak, nonatomic) IBOutlet UILabel *m800Date;
@property (weak, nonatomic) IBOutlet UILabel *m1000BestTime;
@property (weak, nonatomic) IBOutlet UILabel *m1000Date;
@property (weak, nonatomic) IBOutlet UILabel *m1500BestTime;
@property (weak, nonatomic) IBOutlet UILabel *m1500Date;
@property (retain,nonatomic) NSDictionary * mInitData;
@property (retain,nonatomic) NSString * mLongestDisEventId;
@property (retain,nonatomic) NSString * mLongestTimeEventId;
@property (retain,nonatomic) NSString * mBestCaluliId;
@property (retain,nonatomic) NSString * m25EventId;
@property (retain,nonatomic) NSString * m50EventId;
@property (retain,nonatomic) NSString * m100EventId;
@property (retain,nonatomic) NSString * m200EventId;
@property (retain,nonatomic) NSString * m400EventId;
@property (retain,nonatomic) NSString * m800EventId;
@property (retain,nonatomic) NSString * m1000EventId;
@property (retain,nonatomic) NSString * m1500EventId;
@end

@implementation PersonalRecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mInitData = [[NSDictionary alloc]init];
    [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/records/current.do"];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if (section == 0)
    {
        return 6;
        
    }
    else if (section == 1) return 3;
    else return 10;
}
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
    NSString *vUserId = [NSString stringWithFormat:@"%@",dic[@"userId"] ];
    [self.mUserId setText:vUserId];
    NSString *vUserGrade = [NSString stringWithFormat:@"%@",dic[@"userGrade"] ];
    [self.mUserGrade setText:vUserGrade];
    NSString *vSwimmingPoolName = [NSString stringWithFormat:@"%@", dic[@"swimmingPoolName"]];
    [self.mSwimmingPoolName setText:vSwimmingPoolName];
    NSString *vTotalDistance = [NSString stringWithFormat:@"%@", dic[@"distance"] ];
    [self.mTotalDistance setText:vTotalDistance];
    NSString *vSwimmingTime = [NSString stringWithFormat:@"%@", dic[@"swimmingTime"]];
    [self.mTotalSwimmingTime setText:vSwimmingTime];
    NSString *vCaluli = [NSString stringWithFormat:@"%@cal", dic[@"calorie"]];
    [self.mCaluli setText:vCaluli];
    NSString *vLongestEventDis = [NSString stringWithFormat:@"%@", dic[@"longestEventDis"]];
    [self.mLongestEventDis setText:vLongestEventDis];
    NSString *vLongestEventDate =[NSString stringWithFormat:@"%@", dic[@"ledDate"]];
    [self.mLongestEventDate setText:vLongestEventDate];
    NSString *vLedSwimmingPool = [NSString stringWithFormat:@"%@", dic[@"ledSwimmingPool"]];
    [self.mLongestEventPlace setText:vLedSwimmingPool];
    NSString *vLongestEventST = [NSString stringWithFormat:@"%@", dic[@"longestEventST"]];
    [self.mLongestTimeTimt setText: vLongestEventST];
    NSString *vLestDate = [NSString stringWithFormat:@"%@", dic[@"lestDate"]];
    [self.mLongestTimeDate setText:vLestDate];
    NSString *vLestSwimmingPool = [NSString stringWithFormat:@"%@", dic[@"lestSwimmingPool"]];
    [self.mLongestTimePlace setText:vLestSwimmingPool];
    NSString *vBiggestCaluli = [NSString stringWithFormat:@"%@", dic[@"biggestCalorie"]];
    [self.mBigestCalCal setText:vBiggestCaluli];
    NSString *vBcDate = [NSString stringWithFormat:@"%@", dic[@"bcDate"]];
    [self.mBigestCalDate setText:vBcDate];
    NSString *vBcSwimmingPool = [NSString stringWithFormat:@"%@", dic[@"bcSwimmingPool"]];
    [self.mBigestCalPlace setText: vBcSwimmingPool];
    NSString *vM25BestScore = [NSString stringWithFormat:@"%@", dic[@"m25BestScore"]];
    [self.m25BestTime setText:vM25BestScore];
    NSString *vM25Date = [NSString stringWithFormat:@"%@", dic[@"m25Date"]];
    [self.m25Date setText: vM25Date];
    NSString *vM50BestScore = [NSString stringWithFormat:@"%@", dic[@"m50BestScore"]];
    [self.m50BestTime setText:vM50BestScore];
    NSString *vM50Date = [NSString stringWithFormat:@"%@", dic[@"m50Date"]];
    [self.m50Date setText: vM50Date];
    NSString *vM100BestScore = [NSString stringWithFormat:@"%@", dic[@"m100BestScore"]];
    [self.m100BestTime setText:vM100BestScore];
    NSString *vM100Date = [NSString stringWithFormat:@"%@",dic[@"m100Date"]];
    [self.m100Date setText:vM100Date];
    NSString *vM200BestScore = [NSString stringWithFormat:@"%@", dic[@"m200BestScore"]];
    [self.m200BestTime setText:vM200BestScore];
    NSString *vM200Date = [NSString stringWithFormat:@"%@", dic[@"m200Date"]];
    [self.m200Date setText: vM200Date];
    NSString *vM400BestScore = [NSString stringWithFormat:@"%@", dic[@"m400BestScore"]];
    [self.m400BestTime setText:vM400BestScore];
    NSString *vM400Date = [NSString stringWithFormat:@"%@", dic[@"m400Date"]];
    [self.m400Date setText: vM400Date];
    NSString *vM800BestScore = [NSString stringWithFormat:@"%@", dic[@"m800BestScore"]];
    [self.m800BestTime setText:vM800BestScore];
    NSString *vM800Date = [NSString stringWithFormat:@"%@",dic[@"m800Date"]];
    [self.m800Date setText:vM800Date];
    NSString *vM1000BestScore = [NSString stringWithFormat:@"%@", dic[@"m1000BestScore"]];
    [self.m1000BestTime setText:vM1000BestScore];
    NSString *vM1000Date = [NSString stringWithFormat:@"%@",dic[@"m1000Date"]];
    [self.m1000Date setText:vM1000Date];
    NSString *vM1500BestScore = [NSString stringWithFormat:@"%@", dic[@"m1500BestScore"]];
    [self.m1500BestTime setText:vM1500BestScore];
    NSString *vM1500Date = [NSString stringWithFormat:@"%@",dic[@"m1500Date"]];
    [self.m1500Date setText:vM1500Date];
    NSString *vLongestDisId = [NSString stringWithFormat:@"%@", dic[@"ledEventId"]];
    self.mLongestDisEventId = vLongestDisId;
    NSString *vLongestTimeId = [NSString stringWithFormat:@"%@", dic[@"lestEventId"]];
    self.mLongestTimeEventId = vLongestTimeId;
    NSString *vBiggestCalId = [NSString stringWithFormat:@"%@",dic[@"bcEventId"]];
    self.mBestCaluliId = vBiggestCalId;
    NSString *vM25Id = [NSString stringWithFormat:@"%@", dic[@"m25EventId"]];
    self.m25EventId = vM25Id;
    NSString *vM50Id = [NSString stringWithFormat:@"%@", dic[@"m50EventId"]];
    self.m50EventId = vM50Id;
    NSString *vM100Id = [NSString stringWithFormat:@"%@", dic[@"m100EventId"]];
    self.m100EventId = vM100Id;
    NSString *vM200Id = [NSString stringWithFormat:@"%@", dic[@"m200EventId"]];
    self.m200EventId = vM200Id;
    NSString *vM400Id = [NSString stringWithFormat:@"%@", dic[@"m400EventId"]];
    self.m400EventId = vM400Id;
    NSString *vM800Id = [NSString stringWithFormat:@"%@", dic[@"m800EventId"]];
    self.m800EventId = vM800Id;
    NSString *vM1000Id = [NSString stringWithFormat:@"%@", dic[@"m1000EventId"]];
    self.m1000EventId = vM1000Id;
    NSString *vM1500Id = [NSString stringWithFormat:@"%@", dic[@"m1500EventId"]];
    self.m1500EventId = vM1500Id;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
