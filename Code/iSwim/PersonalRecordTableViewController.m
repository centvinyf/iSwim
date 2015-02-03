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
@end

@implementation PersonalRecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mInitData = [[NSDictionary alloc]init];
    [self loadData:@"http://54.172.152.115:9000/api/client/records/current?authToken=b1f329d6d6d5c9614459eb6c2197afffe50c3969!1"];
    
    
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
    NSString *vTotalDistance = [NSString stringWithFormat:@"%.2fkm",[dic[@"totalDistance"] floatValue]/1000];
    [self.mTotalDistance setText:vTotalDistance];
    NSString *vTotalSwimmingTime = [NSString stringWithFormat:@"%.2fh",[dic[@"totalSwimmingTime"] floatValue]/3600];
    [self.mTotalSwimmingTime setText:vTotalSwimmingTime];
    NSString *vLongestDis = [NSString stringWithFormat:@"%.2fkm",[dic[@"longestEventDis"] floatValue]/1000];
    [self.mLongestEventDis setText:vLongestDis];
    NSString *vLongestDate = [dic[@"ledDt"] substringToIndex:10];
    [self.mLongestEventDate setText:vLongestDate];
    NSString *v25mTime = [[dic objectForKey:@"m25Bt"] objectForKey:@"time"];
    [self.m25BestTime setText:v25mTime];
    NSString *v25mDate = [[[dic objectForKey:@"m25Bt"] objectForKey:@"splitDt"] substringToIndex:10];
    [self.m25Date setText:v25mDate];
    NSString *v50mTime = [[dic objectForKey:@"m50Bt"] objectForKey:@"time"];
    [self.m50BestTime setText:v50mTime];
    NSString *v50mDate = [[[dic objectForKey:@"m50Bt"] objectForKey:@"splitDt"] substringToIndex:10];
    [self.m50Date setText:v50mDate];
    NSString *v100mTime = [[dic objectForKey:@"m100Bt"] objectForKey:@"time"];
    [self.m100BestTime setText:v100mTime];
    NSString *v100mDate = [[[dic objectForKey:@"m100Bt"] objectForKey:@"splitDt"] substringToIndex:10];
    [self.m100Date setText:v100mDate];
    NSString *v200mTime = [[dic objectForKey:@"m200Bt"] objectForKey:@"time"];
    [self.m200BestTime setText:v200mTime];
    NSString *v200mDate = [[[dic objectForKey:@"m200Bt"] objectForKey:@"splitDt"] substringToIndex:10];
    [self.m200Date setText:v200mDate];
    NSString *v400mTime = [[dic objectForKey:@"m400Bt"] objectForKey:@"time"];
    [self.m400BestTime setText:v400mTime];
    NSString *v400mDate = [[[dic objectForKey:@"m400Bt"] objectForKey:@"splitDt"] substringToIndex:10];
    [self.m400Date setText:v400mDate];
    NSString *v800mTime = [[dic objectForKey:@"m800Bt"] objectForKey:@"time"];
    [self.m800BestTime setText:v800mTime];
    NSString *v800mDate = [[[dic objectForKey:@"m800Bt"] objectForKey:@"splitDt"] substringToIndex:10];
    [self.m800Date setText:v800mDate];
    NSString *v1000mTime = [[dic objectForKey:@"m1000Bt"] objectForKey:@"time"];
    [self.m1000BestTime setText:v1000mTime];
    NSString *v1000mDate = [[[dic objectForKey:@"m1000Bt"] objectForKey:@"splitDt"] substringToIndex:10];
    [self.m1000Date setText:v1000mDate];
    NSString *v1500mTime = [[dic objectForKey:@"m1500Bt"] objectForKey:@"time"];
    [self.m1500BestTime setText:v1500mTime];
    NSString *v1500mDate = [[[dic objectForKey:@"m1500Bt"] objectForKey:@"splitDt"] substringToIndex:10];
    [self.m1500Date setText:v1500mDate];
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
