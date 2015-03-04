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

@property (strong, nonatomic) IBOutlet UITableView *mTableView;
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
    [self loadData:@"http://192.168.1.113:8080/swimming_app/app/client/events/train.do"];
    
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
-(void) addChartToImageview : (NSArray *) xValues : (NSArray *) yValues :(UIImageView *) imageView
{
    if (mChartFrame.size.width < imageView.frame.size.width)
    {
        mChartFrame = imageView.frame;
    }
    CGRect frame = mChartFrame;
    frame.origin = CGPointZero;
    UIScrollView *chartView = [MBLineChart giveMeAGraphForType:@"总成绩"
                                                       yValues:yValues
                                                       xValues:xValues
                                                         frame:frame
                                                      delegate:nil];
    NSLog(@"%f,%f",frame.size.height,frame.size.width);
    [imageView addSubview:chartView];
}
-(void) initViews : (NSDictionary * )dic
{
    [self addChartToImageview:[self.mInitData[@"LED"] valueForKey:@"X"] :[self.mInitData[@"LED"] valueForKey:@"Y"] :self.mTotalDistance];
    [self addChartToImageview:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"X"] :[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"Y"] :self.mTotalTime];
    [self addChartToImageview:[self.mInitData[@"CALORIE"] valueForKey:@"X"] :[self.mInitData[@"CALORIE"] valueForKey:@"Y"] :self.mTotalCaluli];
    [self addChartToImageview:[self.mInitData[@"M25"] valueForKey:@"X"] :[self.mInitData[@"M25"] valueForKey:@"Y"] :self.m25m];
    [self addChartToImageview:[self.mInitData[@"M50"] valueForKey:@"X"] :[self.mInitData[@"M50"] valueForKey:@"Y"] :self.m50m];
    [self addChartToImageview:[self.mInitData[@"M100"] valueForKey:@"X"] :[self.mInitData[@"M100"] valueForKey:@"Y"] :self.m100m];
    [self addChartToImageview:[self.mInitData[@"M200"] valueForKey:@"X"] :[self.mInitData[@"M200"] valueForKey:@"Y"] :self.m200m];
    [self addChartToImageview:[self.mInitData[@"M400"] valueForKey:@"X"] :[self.mInitData[@"M400"] valueForKey:@"Y"] :self.m400m];
    [self addChartToImageview:[self.mInitData[@"M800"] valueForKey:@"X"] :[self.mInitData[@"M800"] valueForKey:@"Y"] :self.m800m];
    [self addChartToImageview:[self.mInitData[@"M1000"] valueForKey:@"X"] :[self.mInitData[@"M1000"] valueForKey:@"Y"] :self.m1000m];
    [self addChartToImageview:[self.mInitData[@"M1500"] valueForKey:@"X"] :[self.mInitData[@"M1500"] valueForKey:@"Y"] :self.m1500m];

}
@end
