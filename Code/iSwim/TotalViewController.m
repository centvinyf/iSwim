//
//  TotalViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/3/5.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "TotalViewController.h"
#import "MBLineChart.h"
#import "HttpJsonManager.h"
#import "TotalTableViewCell.h"
#import "TrainingDetailViewController.h"
@interface TotalViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *mNaviTitle;
@property (assign,nonatomic) NSInteger mNumOfDetail;
@property (retain,nonatomic) NSDictionary * mInitData;
@property (retain,nonatomic) MBLineChart * mChart;
@property (retain,nonatomic) NSArray * mXArray;
@property(retain,nonatomic) NSArray * mYArray;
@property (retain,nonatomic) NSArray *mZArray;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@end

@implementation TotalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData:@"http://120.25.204.75:8080//swimming_app/app/client/showDetail.do"];
    if ([self.mType isEqualToString:@"LED"])
    {
        self.mNaviTitle.title = @"总距离详情";
    }
    if ([self.mType isEqualToString:@"SWIMMINGTIME"])
    {
        self.mNaviTitle.title = @"总时间详情";
    }
    if ([self.mType isEqualToString:@"CALORIE"])
    {
        self.mNaviTitle.title = @"总消耗详情";
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{@"type": self.mType};
    [HttpJsonManager getWithParameters:parameters
                                   url:url
                     completionHandler:^(BOOL sucess, id content) {
         if (sucess)
         {
             self.mInitData = content;
             NSArray * array = self.mInitData[@"rs"];
             self.mNumOfDetail =array.count;
             
             self.mXArray = self.mInitData[@"chart"][@"X"];
             self.mYArray = self.mInitData[@"chart"][@"Y"];
             self.mZArray = self.mInitData[@"chart"][@"Z"];
             self.mChart = [MBLineChart initGraph:self.mInitData[@"title"]
                                          yValues:self.mYArray
                                          xValues:self.mXArray
                                          zValues:self.mZArray
                                              avg:self.mInitData[@"chart"][@"AVG"]
                                           inView:self.mImageView];
             UIPinchGestureRecognizer *pinch_mTotalCaluli = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommTotalCaluli:)];
             [self.mChart addGestureRecognizer:pinch_mTotalCaluli];
             NSLog(@"%@",content);
             [self.mTableView reloadData];
         }
     }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"Fuck" sender:self.mInitData[@"rs"][indexPath.row][@"eventId"]];

    
}

- (void)zoommTotalCaluli:(UIPinchGestureRecognizer *)sender
{
    [self.mChart updateGraph:sender.scale];
    sender.scale = 1;
    
}

-(void)initViews: (NSArray *)dic
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mNumOfDetail;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        static NSString *vIdentifiller2 = @"Detail";
        
        TotalTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller2];
        if (!vCell)
        {
            vCell = [[TotalTableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier: vIdentifiller2];
        }
        if([self.mType isEqualToString:@"LED"])
        {
            [vCell.mTime setText:self.mInitData[@"rs"][indexPath.row][@"endTime"] ];
            [vCell.mData setText:self.mInitData[@"rs"][indexPath.row][@"distance"] ];
            [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row][@"swimmingPoolName"]];
            [vCell.mInfoType setText:@"本日游泳总距离"];
        }
    if([self.mType isEqualToString:@"SWIMMINGTIME"])
    {
        [vCell.mTime setText:self.mInitData[@"rs"][indexPath.row][@"endTime"]];
        [vCell.mData setText:self.mInitData[@"rs"][indexPath.row][@"swimmingTime"] ];
        [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row][@"swimmingPoolName"]];
        [vCell.mInfoType setText:@"本日游泳总时间"];
    }
    if([self.mType isEqualToString:@"CALORIE"])
    {
        [vCell.mTime setText:self.mInitData[@"rs"][indexPath.row][@"endTime"]];
        [vCell.mData setText:self.mInitData[@"rs"][indexPath.row][@"calorie"]];
        [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row][@"swimmingPoolName"]];
        [vCell.mInfoType setText:@"本日游泳总消耗"];
    }
    

    
    
    
        
        
        
        
        return vCell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Fuck"]) {
        TrainingDetailViewController * vc =[segue destinationViewController];
        vc.mCurrentEventID = sender;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
*/

@end
