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
    NSMutableArray      *_mXArray;
    NSMutableArray      *_mYArray;
    BOOL                _mIsFirst;
}
@property (weak, nonatomic) IBOutlet UIImageView *mBgImageView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mBgImageView.userInteractionEnabled=YES;
    _mXArray=[[NSMutableArray alloc]initWithCapacity:0];
    _mYArray=[[NSMutableArray alloc]initWithCapacity:0];
    _mIsFirst=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    //_mXArray=[[NSMutableArray alloc]initWithObjects:@"sdffsdf",@"ssads",@"ssaaxs",@"sqqqss",@"spppss",@"sdffsdf",@"ssads",@"ssaaxs",@"sqqqss",@"spppss", nil];
    //_mYArray=[[NSMutableArray alloc]initWithObjects:@260,@300,@36.5,@10.9,@105,@260,@300,@36.5,@10.9,@105, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    if (_mIsFirst) {
        [HttpJsonManager getWithParameters:nil sender:self url:[NSString stringWithFormat:@"%@/api/client/updates",SERVERADDRESS] completionHandler:^(BOOL sucess, id content) {
            NSArray*array=[content objectForKey:@"records"];
            _mType = [array[0] objectForKey:@"type"];
            
            if ([_mType isEqualToString:@"DISTANCE"])
            {
                
            }
            else if ([_mType isEqualToString:@"TIME"])
            {
                
            }
            else if ([_mType isEqualToString:@"COLORITE"])
            {
                
            }
            else if ([_mType isEqualToString:@"SPLIT"])
            {
                
            }
            else
            {
                for (int i=0; i<array.count; i++) {
                    NSDictionary*vDic=array[i];
                    [_mXArray addObject:[vDic objectForKey:@"createdDt"]];
                    NSArray*vTimeArray=[[vDic objectForKey:@"time"]componentsSeparatedByString:@":"];
                    float vSecond = [vTimeArray[0] floatValue]*3600+[vTimeArray[1] floatValue]*60+[vTimeArray[2] floatValue];
                    [_mYArray addObject:[NSNumber numberWithFloat:vSecond]];
                }
            }
            CGRect rect=CGRectMake(0, 0, _mBgImageView.frame.size.width, _mBgImageView.frame.size.height);
            UIScrollView *chartView = [MBLineChart giveMeAGraphForType:_mType yValues:_mYArray xValues:_mXArray frame:rect delegate:nil];
            NSLog(@"%@",NSStringFromCGRect(chartView.frame));
            [_mBgImageView addSubview:chartView];
            _mIsFirst=NO;
        }];
    }
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
