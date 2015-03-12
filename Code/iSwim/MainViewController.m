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

@interface MainViewController ()
{
    NSString            * _mType;
    NSArray      *_mXArray;
    NSArray      *_mYArray;
    BOOL                _mIsFirst;
    MBLineChart *mGraphicView;
}
@property (weak, nonatomic) IBOutlet UIImageView *mGraphicViewBG;
@property (weak, nonatomic) IBOutlet UILabel *mUpRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDownMidLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDownRightLabel;
@property (weak, nonatomic) IBOutlet UIButton *mAdButton;
@property (retain,nonatomic) NSDictionary * mAdInfo;
@end

@implementation MainViewController
-(void) viewDidAppear:(BOOL)animated
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"isPro"]) {
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
    [super viewDidLoad];
       // Do any additional setup after loading the view.
    _mXArray=[[NSMutableArray alloc]initWithCapacity:0];
    _mYArray=[[NSMutableArray alloc]initWithCapacity:0];
    _mIsFirst=YES;
    
    [HttpJsonManager getWithParameters:nil
                                sender:self
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
         
         NSDictionary * vAd = [vDic objectForKey:@"ad"];
         self.mAdInfo = vAd;
         NSString *vAdLabel = [vAd objectForKey:@"ad"];
         [self.mAdButton setTitle:vAdLabel forState:UIControlStateNormal];
         [self.mAdButton setTitle:vAdLabel forState:UIControlStateSelected];
     }];
}
- (IBAction)mAdPressed:(id)sender
{
    NSString * vUrl = [self.mAdInfo objectForKey:@"url"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",vUrl]]];
}

- (void)zoommGraphicView:(UIPinchGestureRecognizer *)sender
{
    [mGraphicView updateGraph:sender.scale];
    sender.scale = 1;
    
}


- (void)didReceiveMemoryWarning {
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
