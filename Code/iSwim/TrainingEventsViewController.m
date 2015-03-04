//
//  TrainingEventsViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "TrainingEventsViewController.h"
#import "TrainingEventsTableViewCell.h"
#import "TrainingEventTitleCell.h"
#import "HttpJsonManager.h"
#import "UIScrollView+RefreshControl.h"

@interface TrainingEventsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (retain,nonatomic) NSMutableArray * mInitData;
@property (assign,nonatomic) NSInteger mNumberofDetail;
@property (assign,nonatomic) NSInteger mCurrentPage;
@end

@implementation TrainingEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--

- (void)loadData:(NSString *)url PageIndex:(NSInteger)pageIndex
{
    NSDictionary *parameters = @{@"page":[NSNumber numberWithInteger:pageIndex]};
    [HttpJsonManager getWithParameters:parameters
                                sender:self url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess) {
             [self.mInitData addObjectsFromArray:(NSArray *)content];
             self.mNumberofDetail = self.mInitData.count;
             [self.mTableView reloadData];
             NSLog(@"%@",content);
         }
     }];
}
-(void)initViews
{
    self.mInitData = [[NSMutableArray alloc]init];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";
    self.navigationItem.backBarButtonItem = vReturnButtonItem;
    
    [self.mTableView addTopRefreshControlUsingBlock:^{
        [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/pbts.do" PageIndex:1];
    }];
    self.mCurrentPage = 1;
    
    [self.mTableView addBottomRefreshControlUsingBlock:^{
        self.mCurrentPage ++;
        [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/pbts.do" PageIndex: self.mCurrentPage];
    }];

    [self.mTableView topRefreshControlStartInitializeRefreshing];
}
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * vEventId = [self.mInitData[indexPath.row-1] valueForKey:@"eventId"];
    [self performSegueWithIdentifier:@"toDetail" sender:vEventId];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mNumberofDetail;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *vIdentifiller = @"TrainingEventTitle";
    if (indexPath.row == 0) {
        TrainingEventTitleCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if (!vCell) {
            vCell = [[TrainingEventTitleCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        
        return vCell;
    }
    else{
       static NSString *vIdentifiller2 = @"TrainingEventDetail";
    
        TrainingEventsTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller2];
        if (!vCell) {
            vCell = [[TrainingEventsTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller2];
        }
        NSDictionary * vThisData = self.mInitData [indexPath.row -1];
        [vCell.mTrainingDate setText:[NSString stringWithFormat:@"%@训练基本信息", vThisData[@"endTime"]]];
        [vCell.mEventID setText:[NSString stringWithFormat:@"场次号%@", vThisData[@"eventId"]]];
        [vCell.mTrainingDIs setText:[NSString stringWithFormat:@"%@m",vThisData[@"distance"]]];
        [vCell.mTrainingTime setText:[NSString stringWithFormat:@"%@",vThisData[@"swimmingTime"]]];
        [vCell.mTrainingCal setText:[NSString stringWithFormat:@"%@cal", vThisData[@"calorie"]]];
        [vCell.mTrainingDanbianshu setText:[NSString stringWithFormat:@"%@",vThisData[@"numOfSplit"]]];
        
        
        
        return vCell;

   
}
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }
    else
    {
        return 200;
    }
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [segue.destinationViewController performSelector:@selector(initWithEventId:) withObject:sender];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
