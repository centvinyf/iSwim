//
//  PointsViewController.m
//  iSwim
//
//  Created by Magic Beans on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "PointsViewController.h"
#import "Header.h"
#import "MBLineChart.h"
#import "PointBaseClass.h"
#import "PointsCell.h"
@interface PointsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _mIsFirst;
    NSMutableArray      *_mXArray;
    NSMutableArray      *_mYArray;
    NSArray      *_mZArray;
    NSArray             *_mDataSourceArray;
    NSDictionary        *mInitData;
    BOOL _mIsStart;
    MBLineChart *mGraphicView;
}
@property (weak, nonatomic) IBOutlet UIButton *mStartBtn;
@property (weak, nonatomic) IBOutlet UIButton *mEndBtn;
@property (weak, nonatomic) IBOutlet UIView *mCoverView;
@property (weak, nonatomic) IBOutlet UIDatePicker *mDatePicker;
@property (weak, nonatomic) IBOutlet UIImageView *mGraphicViewBG;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UILabel *mPointsLabel;

@end

@implementation PointsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mDatePicker.maximumDate=[NSDate date];
    _mDatePicker.hidden=YES;
    _mXArray=[[NSMutableArray alloc]initWithCapacity:0];
    _mYArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    [self loadDataWithParameters:nil];
}

-(void)loadDataWithParameters: (NSDictionary *)parameters
{
        [HttpJsonManager getWithParameters:parameters
                                    sender:self
                                       url:[NSString stringWithFormat:@"%@/swimming_app/app/client/profile/points.do",SERVERADDRESS]
                         completionHandler:^(BOOL sucess, id content)
    {
            mInitData = content;
            _mDataSourceArray=(NSArray*)content[@"result"];
            [_mTableView reloadData];
            _mXArray = [mInitData[@"chart"] valueForKey:@"X"];
            _mYArray = [mInitData[@"chart"] valueForKey:@"Y"];
            _mZArray = [mInitData[@"chart"] valueForKey:@"Z"];
            if (mGraphicView)
            {
                [mGraphicView removeFromSuperview];
            }
            
            mGraphicView = [MBLineChart initGraph:[NSString stringWithFormat:@"总积分："]
                           yValues:_mYArray
                           xValues:_mXArray
                           zValues:_mZArray
                               avg:nil 
                            inView:self.mGraphicViewBG];
        [self.mPointsLabel setText:[NSString stringWithFormat:@"%@",mInitData[@"total"]]];
        UILabel * vLabel = self.mPointsLabel;
        [mGraphicView addSubview:vLabel];
            UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommGraphicView:)];
            [mGraphicView addGestureRecognizer:pinch];

        }];
}

- (void)zoommGraphicView:(UIPinchGestureRecognizer *)sender
{
    [mGraphicView updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (IBAction)queryBtnClick:(id)sender
{
    _mCoverView.hidden=!_mCoverView.isHidden;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    [self.mEndBtn.titleLabel setText:strDate];
}

- (IBAction)btnClick:(UIButton *)sender
{
    _mDatePicker.hidden=NO;
    if (sender==_mStartBtn)
    {
        _mIsStart=YES;
    }
    else
    {
        _mIsStart=NO;
    }
    [_mDatePicker date];
}

- (IBAction)coverViewCancelBtnClick:(id)sender
{
    _mCoverView.hidden=YES;
}

- (IBAction)coverViewSureBtnClick:(id)sender
{
    
    _mCoverView.hidden=YES;
    NSDictionary * parameters = @{@"startTime":self.mStartBtn.titleLabel.text,
                                  @"endTime":self.mEndBtn.titleLabel.text};
    [self loadDataWithParameters:parameters];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -datep\Picker delegate And datasource-

- (IBAction)datePickerChangeValues:(UIDatePicker*)sender
{
    NSDateFormatter*vFormatter=[[NSDateFormatter alloc]init];
    vFormatter.dateFormat=@"yyyy-MM-dd";
    NSString*vStr=[vFormatter stringFromDate:[sender date]];
    if (_mIsStart)
    {
        [_mStartBtn setTitle:vStr forState:UIControlStateNormal];
    }
    else
    {
        [_mEndBtn setTitle:vStr forState:UIControlStateNormal];
    }
}


#pragma mark -tableView delegate And datasource-

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mDataSourceArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PointsCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[PointsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary*vPoint=_mDataSourceArray[indexPath.row];
    cell.mDateLab.text=[vPoint objectForKey:@"changeDt"];
    cell.mDesLab.text=[vPoint objectForKey:@"descr"];
    
    cell.mChangeLab.text=[NSString stringWithFormat:@"当前积分：%@",[[vPoint objectForKey:@"pointsAfterChange"] stringValue]];
    cell.mChangeLab.textColor=[UIColor colorWithRed:0x00/255.0 green:0x71/255.0 blue:0x31/255.0 alpha:1];
//    if ([[[vPoint objectForKey:@"change"] substringToIndex:1] isEqual:@"+"])
//    {
//        cell.mChangeLab.text=[NSString stringWithFormat:@"当前积分：%@",[vPoint objectForKey:@"pointsAfterChange"]];
//        cell.mChangeLab.textColor=[UIColor colorWithRed:0x00/255.0 green:0x71/255.0 blue:0x31/255.0 alpha:1];
//    }
//    else
//    {
//        cell.mChangeLab.text=[NSString stringWithFormat:@"积分变化%d",[[vPoint objectForKey:@"change"] intValue]];
//        cell.mChangeLab.textColor=[UIColor colorWithRed:0xd1/255.0 green:0x31/255.0 blue:0x01/255.0 alpha:1];
//    }
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
