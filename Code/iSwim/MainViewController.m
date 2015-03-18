//
//  MainViewController.m
//  iSwim
//
//  Created by Magic Beans on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "MainViewController.h"
#import "MBLineChart.h"
#import "Header.h"
//定义临界天数
#define kExpiredDays 7

@interface MainViewController ()
{
    NSString            * _mType;
    NSArray      *_mXArray;
    NSArray      *_mYArray;
    BOOL                _mIsexpired;
    MBLineChart *mGraphicView;
}

@property (weak, nonatomic) IBOutlet UIImageView *mGraphicViewBG;
@property (weak, nonatomic) IBOutlet UILabel *mUpRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDownMidLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDownRightLabel;
@property (weak, nonatomic) IBOutlet UIButton *mAdButton;
@property (weak, nonatomic) IBOutlet UIScrollView *mMoreThan5; //业余N天后主页图形
@property (retain,nonatomic) NSDictionary * mAdInfo;
@property (weak, nonatomic) IBOutlet UIScrollView *mLessThan5;//业余N天内主页图形
@property (weak, nonatomic) IBOutlet UILabel *mLess5Distance;
@property (weak, nonatomic) IBOutlet UILabel *mLess5Time;
@property (weak, nonatomic) IBOutlet UILabel *mLess5Cal;
@property (weak, nonatomic) IBOutlet UILabel *mLess5Date;
@property (weak, nonatomic) IBOutlet UILabel *mMore5Day;
@property (weak, nonatomic) IBOutlet UILabel *mMore5Time;
@property (weak, nonatomic) IBOutlet UILabel *mMore5Distance;
@property (weak, nonatomic) IBOutlet UILabel *mMore5Cal;
@property (weak, nonatomic) IBOutlet UILabel *mMore5Date;
@property (retain,nonatomic) NSDictionary * mNoProInfo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTopLabelCon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCircleCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mLessTopLabelCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mLessCircleCon;

@end

@implementation MainViewController
-(void) viewDidAppear:(BOOL)animated
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"isPro"])
    {
        [self.mUpRightLabel setText:@"训练成绩"];
        [self.mDownMidLabel setText:@"训练事件"];
        [self.mDownRightLabel setText:@"训练详情"];
    }
    else
    {
        [self.mUpRightLabel setText:@"游泳成绩"];
        [self.mDownMidLabel setText:@"游泳事件"];
        [self.mDownRightLabel setText:@"游泳详情"];
    }
   
}

- (void)viewDidLoad
{
    if ([UIScreen mainScreen].bounds.size.height>600)//适配iphone 6和 6+的业余主界面图形位置
    {
        
        self.mCircleCon.constant+=60;
        self.mTopLabelCon.constant+=60;
        self.mLessCircleCon.constant +=60;
        self.mLessTopLabelCon.constant +=60;
       
        
    }
    
    [super viewDidLoad];
    
//    [defaults setBool:nil forKey:@"isPro"];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self initViews];
}

- (void)loadData
{
    _mXArray=[[NSMutableArray alloc]initWithCapacity:0];
    _mYArray=[[NSMutableArray alloc]initWithCapacity:0];

    //专业
    [HttpJsonManager getWithParameters:nil
                                   url:[NSString stringWithFormat:@"%@/swimming_app/app/client/profile/break.do",SERVERADDRESS]
                     completionHandler:^(BOOL sucess, id content)
     {
         NSDictionary*vDic=content;
         _mXArray = [[vDic objectForKey:@"chart"] objectForKey:@"X"] ;
         _mYArray = [[vDic objectForKey:@"chart"] objectForKey:@"Y"];
         NSArray * _mZArray = [[vDic objectForKey:@"chart"] objectForKey:@"Z"];
         _mType = [vDic objectForKey:@"title"];
         mGraphicView = [MBLineChart initGraph:_mType
                                       yValues:_mYArray
                                       xValues:_mXArray
                                       zValues:_mZArray
                                           avg:[[vDic objectForKey:@"chart"] objectForKey:@"AVG"]
                                        inView:self.mGraphicViewBG];
         UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommGraphicView:)];
         [mGraphicView addGestureRecognizer:pinch];
     }];

    //业余
    [HttpJsonManager getWithParameters:nil
                                   url:[NSString stringWithFormat:@"%@/swimming_app/app/client/profile/indexInfo.do",SERVERADDRESS]
                     completionHandler:^(BOOL sucess, id content)
    {
                         if (sucess)
                         {
                             self.mNoProInfo = content;
                             NSDictionary *vInfoDic = content[@"info"];
                             //计算上一次训练举例今天的天数
                             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                             formatter.dateFormat = @"yyyy-MM-dd";
                             NSDate *lastDate = [formatter dateFromString:vInfoDic[@"endTime"]];
                             NSTimeInterval timeInterval = [lastDate timeIntervalSinceNow];
                             
                             _mIsexpired = abs(timeInterval) >= kExpiredDays * 24 * 3600;
                             
                             NSDictionary * vAd = [content objectForKey:@"ad"];
                             self.mAdInfo = vAd;
                             NSString *vAdLabel = [vAd objectForKey:@"ad"];
                             [self.mAdButton setTitle:vAdLabel forState:UIControlStateNormal];
                             //加载完成数据后根据专业与否与用户时间加载不同主页
                             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                             if ([defaults boolForKey:@"isPro"])
                             {
                                 self.mMoreThan5.hidden = YES;
                                 self.mLessThan5.hidden = YES;
                                 self.mGraphicViewBG.hidden = NO;
                             }
                             else
                             {
                                 
                                 
                                 if(_mIsexpired)
                                 {
                                     //大于规定的天数
                                     self.mGraphicViewBG.hidden = YES;
                                     self.mLessThan5.hidden = YES;
                                     self.mMoreThan5.hidden = NO;
                                     
                                 }
                                 else
                                 {
                                     //小于规定的天数
                                     self.mGraphicViewBG.hidden = YES;
                                     self.mLessThan5.hidden = NO;
                                     self.mMoreThan5.hidden = YES;
                                     
                                 }
                             }

                             if(_mIsexpired)
                             {
                                 //大于规定的天数
//                                 self.mLessThan5.hidden = YES;
//                                 self.mMoreThan5.hidden = NO;
                                 self.mMore5Cal.text = vInfoDic[@"totalCalorie"];
                                 self.mMore5Date.text = vInfoDic[@"endTime"];
                                 self.mMore5Day.text = [NSString stringWithFormat:@"%d天",(int)abs(timeInterval/24/3600)];
                                 self.mMore5Distance.text = vInfoDic[@"totalDistance"];
                                 self.mMore5Time.text = vInfoDic[@"totalTime"];
                                 
                             }
                             else
                             {
                                 //小于规定的天数
//                                 self.mLessThan5.hidden = NO;
//                                 self.mMoreThan5.hidden = YES;
                                 self.mLess5Time.text = vInfoDic[@"totalTime"];
                                 self.mLess5Cal.text = vInfoDic[@"totalCalorie"];
                                 self.mLess5Date.text = vInfoDic[@"endTime"];
                                 self.mLess5Distance.text = vInfoDic[@"totalDistance"];
                             }
                         }
    }];

}

- (void)initViews
{
 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"isPro"])
    {
        self.mMoreThan5.hidden = YES;
        self.mLessThan5.hidden = YES;
        self.mGraphicViewBG.hidden = NO;
    }
    else
    {
        
        
        if(_mIsexpired)
        {
            //大于规定的天数
            self.mGraphicViewBG.hidden = YES;
            self.mLessThan5.hidden = YES;
            self.mMoreThan5.hidden = NO;
            
        }
        else
        {
            //小于规定的天数
            self.mGraphicViewBG.hidden = YES;
            self.mLessThan5.hidden = NO;
            self.mMoreThan5.hidden = YES;
            
        }
    }

}

- (IBAction)mAdPressed:(id)sender
{
    NSString * vUrl = [self.mAdInfo objectForKey:@"url"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:vUrl]];
}

- (void)zoommGraphicView:(UIPinchGestureRecognizer *)sender
{
    [mGraphicView updateGraph:sender.scale];
    sender.scale = 1;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showMyRecord:(id)sender
{
    UIStoryboard *vStoryBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *vMyRecordViewController = [vStoryBoard instantiateViewControllerWithIdentifier:@"MyRecordViewController"];
    [self.navigationController pushViewController:vMyRecordViewController animated:YES];
}

- (IBAction)showTrainingRecords:(id)sender
{
    UIStoryboard *vStoryBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *vMyRecordViewController = [vStoryBoard instantiateViewControllerWithIdentifier:@"TrainingRecordsViewController"];
    [self.navigationController pushViewController:vMyRecordViewController animated:YES];

}

- (IBAction)showPointsDetail:(id)sender
{
    UIStoryboard *vStoryBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *vPointsViewController = [vStoryBoard instantiateViewControllerWithIdentifier:@"PointsViewController"];
    [self.navigationController pushViewController:vPointsViewController animated:YES];
}

- (IBAction)showTrainingEvents:(id)sender
{
    UIStoryboard *vStoryBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *vPointsViewController = [vStoryBoard instantiateViewControllerWithIdentifier:@"TrainingEventsViewController"];
    [self.navigationController pushViewController:vPointsViewController animated:YES];
}

- (IBAction)showTrainingDetail:(id)sender
{
    UIStoryboard *vStoryBoard = [UIStoryboard storyboardWithName:@"Records" bundle:nil];
    UIViewController *vMyRecordViewController = [vStoryBoard instantiateViewControllerWithIdentifier:@"TrainingDetailViewController"];
    [self.navigationController pushViewController:vMyRecordViewController animated:YES];
}
@end
