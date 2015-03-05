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

@implementation TrainingRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/events/train.do"];
    
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
         }
     }];
}

-(void) initViews : (NSDictionary * )dic
{
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"LED"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"LED"] valueForKey:@"X"]
                    inView:self.mTotalDistance];
    
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"X"]
                    inView:self.mTotalTime];
    
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"CALORIE"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"CALORIE"] valueForKey:@"X"]
                    inView:self.mTotalCaluli];
    
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"M25"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"M25"] valueForKey:@"X"]
                    inView:self.m25m];
    
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"M50"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"M50"] valueForKey:@"X"]
                    inView:self.m50m];
    
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"M100"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"M100"] valueForKey:@"X"]
                    inView:self.m100m];
    
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"M200"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"M200"] valueForKey:@"X"]
                    inView:self.m200m];
    
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"M400"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"M400"] valueForKey:@"X"]
                    inView:self.m400m];
    
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"M800"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"M800"] valueForKey:@"X"]
                    inView:self.m800m];
    
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"M1000"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"M1000"] valueForKey:@"X"]
                    inView:self.m1000m];
    
    [MBLineChart initGraph:@"title"
                   yValues:[self.mInitData[@"M1500"] valueForKey:@"Y"]
                   xValues:[self.mInitData[@"M1500"] valueForKey:@"X"]
                    inView:self.m1500m];

}

@end
