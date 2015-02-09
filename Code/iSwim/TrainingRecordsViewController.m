//
//  TrainingRecordsViewController.m
//  iSwim
//
//  Created by Magic Beans on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "TrainingRecordsViewController.h"
#import "HttpJsonManager.h"
#import "MBLineChart.h"
@interface TrainingRecordsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mTotalDistance;

@property (weak, nonatomic) IBOutlet UIImageView *mTotalTime;
@property (weak, nonatomic) IBOutlet UIImageView *mTotalCaluli;
@property (weak, nonatomic) IBOutlet UIImageView *m25m;
@property (weak, nonatomic) IBOutlet UIImageView *m50m;
@property (weak, nonatomic) IBOutlet UIImageView *m100m;
@property (weak, nonatomic) IBOutlet UIImageView *m200m;
@property (weak, nonatomic) IBOutlet UIImageView *m400m;
@property (weak, nonatomic) IBOutlet UIImageView *m800m;
@property (weak, nonatomic) IBOutlet UIImageView *m1000m;
@property (weak, nonatomic) IBOutlet UIImageView *m1500m;
@property (retain,nonatomic) NSDictionary * mInitData;
@end

@implementation TrainingRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:@"http://54.172.152.115:9000/api/client/pbts?authToken=b1f329d6d6d5c9614459eb6c2197afffe50c3969!1&startDt=2015-1-1&endDt=2015-10-1&baseEventId=10"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void) addChartToImageview : (NSArray *) xValues : (NSArray *) yValues :(UIImageView *) imageView
{
    UIScrollView *chartView = [MBLineChart giveMeAGraphForType:@"总成绩"
                                                       yValues:yValues
                                                       xValues:xValues
                                                         frame:imageView.frame
                                                      delegate:nil];
    [imageView addSubview:chartView];
}
-(void) initViews : (NSDictionary * )dic
{
    
}
@end
