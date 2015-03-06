//
//  TrainingDetailViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "TrainingDetailViewController.h"
#import "HttpJsonManager.h"
#import "MBLineChart.h"

@interface TrainingDetailViewController ()
@property (retain,nonatomic) NSDictionary * mInitData;
@property (weak, nonatomic) IBOutlet MBLineChart *mGraphicView;
@property (retain,nonatomic) NSArray * mXArray;
@property (retain,nonatomic) NSArray * mYArray;
@property (retain,nonatomic) NSString * mCurrentEventID;

@end

@implementation TrainingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";//改改改
    self.navigationItem.backBarButtonItem = vReturnButtonItem;
    [self loadEventIdData:@"http://192.168.1.113:8081/swimming_app/app/client/events/info/enevtId.do"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--
- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{
                                 @"eventId": self.mCurrentEventID,
                                 @"page": @1};
    [HttpJsonManager getWithParameters:parameters
                                sender:self url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess) {
             self.mInitData = content;
             self.mXArray = [self.mInitData valueForKey:@"X"];
             self.mYArray = [self.mInitData valueForKey:@"Y"];
             [MBLineChart initGraph:@"本场分段详情"
                            yValues:self.mYArray
                            xValues:self.mXArray
                             inView:self.mGraphicView];
    }
     }];
}

- (void)loadEventIdData:(NSString *)url
{
    NSDictionary *parameters = @{};
    [HttpJsonManager getWithParameters:parameters
                                sender:self url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess) {
             if (!self.mCurrentEventID) {
                  self.mCurrentEventID = content[@"eventId"];
             }
            
            NSLog(@"%@",content);
             [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/events/split/chart.do"];
             
         }
     }];
}
-(void)initWithEventId : (NSString *) EventID
{
    self.mCurrentEventID = EventID;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    sender = self.mCurrentEventID;
    [segue.destinationViewController performSelector:@selector(initWithEventId:) withObject:sender];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
*/

@end
