//
//  DetailViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/3/5.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "HttpJsonManager.h"
#import "MBLineChart.h"
#import "TrainingDetailViewController.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (assign,nonatomic) NSInteger mNumOfDetail;
@property (retain,nonatomic) NSDictionary * mInitData;
@property (retain,nonatomic) MBLineChart * mChart;
@property (retain,nonatomic) NSArray * mXArray;
@property(retain,nonatomic) NSArray * mYArray;
@property (weak, nonatomic) IBOutlet UINavigationItem *mTitle;
@property(retain,nonatomic) NSArray * mZArray;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/showDetail.do"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{@"type": self.mType};
    [HttpJsonManager getWithParameters:parameters
                                sender:self url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess) {
             self.mInitData = content;
             NSArray * array = self.mInitData[@"rs"];
             self.mNumOfDetail =array.count;
             
             self.mXArray = self.mInitData[@"chart"][@"X"];
             self.mYArray = self.mInitData[@"chart"][@"Y"];
             self.mZArray = self.mInitData[@"chart"][@"Z"];
        self.mChart = [MBLineChart initGraph:self.mInitData[@"title"]
                                             yValues:self.mYArray
                                             xValues:self.mXArray
                                             zValues:self.mZArray
                                                 avg:self.mInitData[@"chart"][@"AVG"]
                                              inView:self.mImageView];
             UIPinchGestureRecognizer *pinch_mTotalCaluli = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommTotalCaluli:)];
             [self.mChart addGestureRecognizer:pinch_mTotalCaluli];
             NSLog(@"%@",content);
             [self.mTableView reloadData];
             [self.mTitle setTitle:self.mInitData[@"title"]];
         }
     }];
}
- (void)zoommTotalCaluli:(UIPinchGestureRecognizer *)sender
{
    [self.mChart updateGraph:sender.scale];
    sender.scale = 1;
    
}
-(void)initViews: (NSArray *)dic
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 60;
    else
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mNumOfDetail+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *vIdentifiller = @"Title";
    if (indexPath.row == 0) {
        DetailTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if (!vCell) {
            vCell = [[DetailTableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier: vIdentifiller];
        }
        
        return vCell;
    }
    else{
        static NSString *vIdentifiller2 = @"Detail";

        DetailTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller2];
        if (!vCell)
        {
            vCell = [[DetailTableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier: vIdentifiller2];
        }
        if ([self.mType isEqualToString:@"M25"]) {
            NSString * vSingleInfo = [NSString stringWithFormat:@"%@/%@",self.mInitData[@"rs"][indexPath.row-1][@"m25StartId"],self.mInitData[@"rs"][indexPath.row-1][@"m25EndId"]];
            [vCell.mTime setText: self.mInitData[@"rs"][indexPath.row-1][@"m25BestScore"]];
            [vCell.mDate setText:self.mInitData[@"rs"][indexPath.row-1][@"endTime"]];
            [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row-1][@"swimmingPoolName"]];
            [vCell.mSingle setText: vSingleInfo];
        }if ([self.mType isEqualToString:@"M50"]) {
            NSString * vSingleInfo = [NSString stringWithFormat:@"%@/%@",self.mInitData[@"rs"][indexPath.row-1][@"m50StartId"],self.mInitData[@"rs"][indexPath.row-1][@"m50EndId"]];
            [vCell.mTime setText: self.mInitData[@"rs"][indexPath.row-1][@"m50BestScore"]];
            [vCell.mDate setText:self.mInitData[@"rs"][indexPath.row-1][@"endTime"]];
            [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row-1][@"swimmingPoolName"]];
            [vCell.mSingle setText: vSingleInfo];
        }if ([self.mType isEqualToString:@"M100"]) {
            NSString * vSingleInfo = [NSString stringWithFormat:@"%@/%@",self.mInitData[@"rs"][indexPath.row-1][@"m100StartId"],self.mInitData[@"rs"][indexPath.row-1][@"m100EndId"]];
            [vCell.mTime setText: self.mInitData[@"rs"][indexPath.row-1][@"m100BestScore"]];
            [vCell.mDate setText:self.mInitData[@"rs"][indexPath.row-1][@"endTime"]];
            [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row-1][@"swimmingPoolName"]];
            [vCell.mSingle setText: vSingleInfo];
        }if ([self.mType isEqualToString:@"M200"]) {
            NSString * vSingleInfo = [NSString stringWithFormat:@"%@/%@",self.mInitData[@"rs"][indexPath.row-1][@"m200StartId"],self.mInitData[@"rs"][indexPath.row-1][@"m200EndId"]];
            [vCell.mTime setText: self.mInitData[@"rs"][indexPath.row-1][@"m200BestScore"]];
            [vCell.mDate setText:self.mInitData[@"rs"][indexPath.row-1][@"endTime"]];
            [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row-1][@"swimmingPoolName"]];
            [vCell.mSingle setText: vSingleInfo];
        }if ([self.mType isEqualToString:@"M400"]) {
            NSString * vSingleInfo = [NSString stringWithFormat:@"%@/%@",self.mInitData[@"rs"][indexPath.row-1][@"m400StartId"],self.mInitData[@"rs"][indexPath.row-1][@"m400EndId"]];
            [vCell.mTime setText: self.mInitData[@"rs"][indexPath.row-1][@"m400BestScore"]];
            [vCell.mDate setText:self.mInitData[@"rs"][indexPath.row-1][@"endTime"]];
            [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row-1][@"swimmingPoolName"]];
            [vCell.mSingle setText: vSingleInfo];
        }if ([self.mType isEqualToString:@"M800"]) {
            NSString * vSingleInfo = [NSString stringWithFormat:@"%@/%@",self.mInitData[@"rs"][indexPath.row-1][@"m800StartId"],self.mInitData[@"rs"][indexPath.row-1][@"m800EndId"]];
            [vCell.mTime setText: self.mInitData[@"rs"][indexPath.row-1][@"m800BestScore"]];
            [vCell.mDate setText:self.mInitData[@"rs"][indexPath.row-1][@"endTime"]];
            [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row-1][@"swimmingPoolName"]];
            [vCell.mSingle setText: vSingleInfo];
        }if ([self.mType isEqualToString:@"M1000"]) {
            NSString * vSingleInfo = [NSString stringWithFormat:@"%@/%@",self.mInitData[@"rs"][indexPath.row-1][@"m1000StartId"],self.mInitData[@"rs"][indexPath.row-1][@"m1000EndId"]];
            [vCell.mTime setText: self.mInitData[@"rs"][indexPath.row-1][@"m1000BestScore"]];
            [vCell.mDate setText:self.mInitData[@"rs"][indexPath.row-1][@"endTime"]];
            [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row-1][@"swimmingPoolName"]];
            [vCell.mSingle setText: vSingleInfo];
        }if ([self.mType isEqualToString:@"M1500"]) {
            NSString * vSingleInfo = [NSString stringWithFormat:@"%@/%@",self.mInitData[@"rs"][indexPath.row-1][@"m1500StartId"],self.mInitData[@"rs"][indexPath.row-1][@"m1500EndId"]];
            [vCell.mTime setText: self.mInitData[@"rs"][indexPath.row-1][@"m1500BestScore"]];
            [vCell.mDate setText:self.mInitData[@"rs"][indexPath.row-1][@"endTime"]];
            [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row-1][@"swimmingPoolName"]];
            [vCell.mSingle setText: vSingleInfo];
        }




        
        
        
        return vCell;    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Fucku"]) {
        TrainingDetailViewController * vc =[segue destinationViewController];
        vc.mCurrentEventID = sender;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>0) {
        [self performSegueWithIdentifier:@"Fucku" sender:self.mInitData[@"rs"][indexPath.row-1][@"eventId"]];

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

@end
