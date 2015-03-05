//
//  HistoryTableViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/3/3.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//
#import "HistoryTableViewController.h"
#import "HttpJsonManager.h"
#import "MBLineChart.h"
@interface HistoryTableViewController ()

@property (weak, nonatomic) IBOutlet MBLineChart *mTotalDistance;
@property (weak, nonatomic) IBOutlet MBLineChart *mTotalTime;
@property (weak, nonatomic) IBOutlet MBLineChart *mTotalCaluli;
@property (weak, nonatomic) IBOutlet MBLineChart *m25m;
@property (weak, nonatomic) IBOutlet MBLineChart *m50m;
@property (weak, nonatomic) IBOutlet MBLineChart *m100m;
@property (weak, nonatomic) IBOutlet MBLineChart *m200m;
@property (weak, nonatomic) IBOutlet MBLineChart *m400m;
@property (weak, nonatomic) IBOutlet MBLineChart *m800m;
@property (weak, nonatomic) IBOutlet MBLineChart *m1000m;
@property (weak, nonatomic) IBOutlet MBLineChart *m1500m;
@property (retain,nonatomic) NSDictionary * mInitData;
@end

@implementation HistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/records.do"];
    
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
             //             [self.mTableView reloadData];
             //             NSLog(@"%@",content);
         }
     }];
}

-(void) initViews : (NSDictionary * )dic
{
    [self.mTotalDistance initGraph:@"title" yValues:[self.mInitData[@"LED"] valueForKey:@"Y"] xValues:[self.mInitData[@"LED"] valueForKey:@"X"]];
    [self.mTotalTime initGraph:@"title" yValues:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"Y"] xValues:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"X"]];
    [self.mTotalCaluli initGraph:@"title" yValues:[self.mInitData[@"CALORIE"] valueForKey:@"Y"] xValues:[self.mInitData[@"CALORIE"] valueForKey:@"X"]];
    [self.m25m initGraph:@"title" yValues:[self.mInitData[@"M25"] valueForKey:@"Y"] xValues:[self.mInitData[@"M25"] valueForKey:@"X"]];
    [self.m50m initGraph:@"title" yValues:[self.mInitData[@"M50"] valueForKey:@"Y"] xValues:[self.mInitData[@"M50"] valueForKey:@"X"]];
    [self.m100m initGraph:@"title" yValues:[self.mInitData[@"M100"] valueForKey:@"Y"] xValues:[self.mInitData[@"M100"] valueForKey:@"X"]];
    [self.m200m initGraph:@"title" yValues:[self.mInitData[@"M200"] valueForKey:@"Y"] xValues:[self.mInitData[@"M200"] valueForKey:@"X"]];
    [self.m400m initGraph:@"title" yValues:[self.mInitData[@"M400"] valueForKey:@"Y"] xValues:[self.mInitData[@"M400"] valueForKey:@"X"]];
    [self.m800m initGraph:@"title" yValues:[self.mInitData[@"M800"] valueForKey:@"Y"] xValues:[self.mInitData[@"M800"] valueForKey:@"X"]];
    [self.m1000m initGraph:@"title" yValues:[self.mInitData[@"M1000"] valueForKey:@"Y"] xValues:[self.mInitData[@"M1000"] valueForKey:@"X"]];
    [self.m1500m initGraph:@"title" yValues:[self.mInitData[@"M1500"] valueForKey:@"Y"] xValues:[self.mInitData[@"M1500"] valueForKey:@"X"]];
}
@end