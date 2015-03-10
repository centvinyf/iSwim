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
{
    MBLineChart *mTotalDistance;
    MBLineChart *mTotalTime;
    MBLineChart *mTotalCaluli;
    MBLineChart *m25m;
    MBLineChart *m50m;
    MBLineChart *m100m;
    MBLineChart *m200m;
    MBLineChart *m400m;
    MBLineChart *m800m;
    MBLineChart *m1000m;
    MBLineChart *m1500m;

}
@property (weak, nonatomic) IBOutlet UIImageView *mTotalDistanceBG;
@property (weak, nonatomic) IBOutlet UIImageView *mTotalTimeBG;
@property (weak, nonatomic) IBOutlet UIImageView *mTotalCaluliBG;
@property (weak, nonatomic) IBOutlet UIImageView *m25mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m50mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m100mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m200mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m400mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m800mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m1000mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m1500mBG;
@property (retain,nonatomic) NSDictionary * mInitData;
@end

@implementation HistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:@"http://192.168.1.113:8080/swimming_app/app/client/records.do"];
    
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
    mTotalDistance = [MBLineChart initGraph:@"单次训练最大距离"
                                    yValues:[self.mInitData[@"LED"] valueForKey:@"Y"]
                                    xValues:[self.mInitData[@"LED"] valueForKey:@"X"]
                                    zValues:[self.mInitData[@"LED"] valueForKey:@"Z"]
                                     inView:self.mTotalDistanceBG];
    UIPinchGestureRecognizer *pinch_mTotalDistance = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommTotalDistance:)];
    [mTotalDistance addGestureRecognizer:pinch_mTotalDistance];
  

    
    mTotalTime = [MBLineChart initGraph:@"单次训练最长时间"
                                yValues:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"Y"]
                                xValues:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"X"]
                                zValues:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"Z"]
                                 inView:self.mTotalTimeBG];
    UIPinchGestureRecognizer *pinch_mTotalTime = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommTotalTime:)];
    [mTotalTime addGestureRecognizer:pinch_mTotalTime];
    
    mTotalCaluli = [MBLineChart initGraph:@"单次训练最大消耗"
                                  yValues:[self.mInitData[@"CALORIE"] valueForKey:@"Y"]
                                  xValues:[self.mInitData[@"CALORIE"] valueForKey:@"X"]
                                  zValues:[self.mInitData[@"CALORIE"] valueForKey:@"Z"]
                                   inView:self.mTotalCaluliBG];
    UIPinchGestureRecognizer *pinch_mTotalCaluli = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommTotalCaluli:)];
    [mTotalCaluli addGestureRecognizer:pinch_mTotalCaluli];
   
    
    
    m25m = [MBLineChart initGraph:@"25m"
                          yValues:[self.mInitData[@"M25"] valueForKey:@"Y"]
                          xValues:[self.mInitData[@"M25"] valueForKey:@"X"]
                          zValues:[self.mInitData[@"M25"] valueForKey:@"Z"]
                           inView:self.m25mBG];
    UIPinchGestureRecognizer *pinch_m25m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm25m:)];
    [m25m addGestureRecognizer:pinch_m25m];
    
    
    
    m50m = [MBLineChart initGraph:@"50m"
                          yValues:[self.mInitData[@"M50"] valueForKey:@"Y"]
                          xValues:[self.mInitData[@"M50"] valueForKey:@"X"]
                          zValues:[self.mInitData[@"M50"] valueForKey:@"Z"]
                           inView:self.m50mBG];
    UIPinchGestureRecognizer *pinch_m50m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm50m:)];
    [m50m addGestureRecognizer:pinch_m50m];
   
    
    m100m = [MBLineChart initGraph:@"100m"
                           yValues:[self.mInitData[@"M100"] valueForKey:@"Y"]
                           xValues:[self.mInitData[@"M100"] valueForKey:@"X"]
                           zValues:[self.mInitData[@"M100"] valueForKey:@"Z"]
                            inView:self.m100mBG];
    UIPinchGestureRecognizer *pinch_m100m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm100m:)];
    [m100m addGestureRecognizer:pinch_m100m];
    
    
    m200m = [MBLineChart initGraph:@"200m"
                           yValues:[self.mInitData[@"M200"] valueForKey:@"Y"]
                           xValues:[self.mInitData[@"M200"] valueForKey:@"X"]
                           zValues:[self.mInitData[@"M200"] valueForKey:@"Z"]
                            inView:self.m200mBG];
    UIPinchGestureRecognizer *pinch_m200m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm200m:)];
    [m200m addGestureRecognizer:pinch_m200m];
   
    
    m400m = [MBLineChart initGraph:@"400m"
                           yValues:[self.mInitData[@"M400"] valueForKey:@"Y"]
                           xValues:[self.mInitData[@"M400"] valueForKey:@"X"]
                           zValues:[self.mInitData[@"M400"] valueForKey:@"Z"]
                            inView:self.m400mBG];
    UIPinchGestureRecognizer *pinch_m400m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm400m:)];
    [m400m addGestureRecognizer:pinch_m400m];
    
    m800m = [MBLineChart initGraph:@"800m"
                           yValues:[self.mInitData[@"M800"] valueForKey:@"Y"]
                           xValues:[self.mInitData[@"M800"] valueForKey:@"X"]
                           zValues:[self.mInitData[@"M800"] valueForKey:@"Z"]
                            inView:self.m800mBG];
    UIPinchGestureRecognizer *pinch_m800m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm800m:)];
    [m800m addGestureRecognizer:pinch_m800m];
   
    
    m1000m = [MBLineChart initGraph:@"1000m"
                            yValues:[self.mInitData[@"M1000"] valueForKey:@"Y"]
                            xValues:[self.mInitData[@"M1000"] valueForKey:@"X"]
                            zValues:[self.mInitData[@"M1000"] valueForKey:@"Z"]
                             inView:self.m1000mBG];
    UIPinchGestureRecognizer *pinch_m1000m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm1000m:)];
    [m1000m addGestureRecognizer:pinch_m1000m];
   
    
    m1500m = [MBLineChart initGraph:@"1500m"
                            yValues:[self.mInitData[@"M1500"] valueForKey:@"Y"]
                            xValues:[self.mInitData[@"M1500"] valueForKey:@"X"]
                            zValues:[self.mInitData[@"M1500"] valueForKey:@"Z"]
                             inView:self.m1500mBG];
    UIPinchGestureRecognizer *pinch_m1500m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm1500m:)];
    [m1500m addGestureRecognizer:pinch_m1500m];
   
    
}
- (void)zoommTotalDistance:(UIPinchGestureRecognizer *)sender
{
    [mTotalDistance updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoommTotalTime:(UIPinchGestureRecognizer *)sender
{
    [mTotalTime updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoommTotalCaluli:(UIPinchGestureRecognizer *)sender
{
    [mTotalCaluli updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm25m:(UIPinchGestureRecognizer *)sender
{
    [m25m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm50m:(UIPinchGestureRecognizer *)sender
{
    [m50m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm100m:(UIPinchGestureRecognizer *)sender
{
    [m1000m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm200m:(UIPinchGestureRecognizer *)sender
{
    [m200m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm400m:(UIPinchGestureRecognizer *)sender
{
    [m400m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm800m:(UIPinchGestureRecognizer *)sender
{
    [m800m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm1000m:(UIPinchGestureRecognizer *)sender
{
    [m1000m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm1500m:(UIPinchGestureRecognizer *)sender
{
    [m1500m updateGraph:sender.scale];
    sender.scale = 1;
    
}
@end