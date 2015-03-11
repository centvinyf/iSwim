//
//  RankingViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/28.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "RankingViewController.h"
#import "TrainingPlanTableViewCell.h"
#import "TwoLabelTableViewCell.h"
#import "PaimingTableViewCell.h"
#import "ThreeLabelTableViewCell.h"
#import "HttpJsonManager.h"
@interface RankingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (retain,nonatomic) NSDictionary * mInitData;
@property (retain,nonatomic) NSString * mCurrentEventId;
@end

@implementation RankingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";//改改改
    self.navigationItem.backBarButtonItem = vReturnButtonItem;
    [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/events/ranking.do"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--

- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{@"eventId": self.mCurrentEventId};
    [HttpJsonManager getWithParameters:parameters
                                sender:self
                                   url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess)
         {
             self.mInitData = content;
             [self initViews:self.mInitData];
             NSLog(@"%@",content);
             [self.mTableView reloadData];
         }
     }];
}

-(void)initViews: (NSDictionary *)dic
{
    
}

-(void) initWithEventId : (NSString *)EventId
{
    self.mCurrentEventId = EventId;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7||indexPath.row == 0)
    {
        return 20;
    }
    else
    {
        return 40;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray * vTitle = [[NSMutableArray alloc]initWithArray:[[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"本场距离排名",@"本场时长排名",@"本场消耗排名",@"训练场馆", nil]];
    NSArray * vButton= [[NSArray alloc] initWithObjects:@"training_date",@"Training_changci",@"training_distance",@"training_time",@"energy",@"place", nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"isPro"])
    {
       vTitle = [[NSMutableArray alloc]initWithArray:[[NSArray alloc] initWithObjects:@"训练日期",@"训练场次",@"本场距离排名",@"本场时长排名",@"本场消耗排名",@"训练场馆", nil]];
    }else
    {
       vTitle = [[NSMutableArray alloc]initWithArray:[[NSArray alloc] initWithObjects:@"游泳日期",@"游泳场次",@"本场距离排名",@"本场时长排名",@"本场消耗排名",@"游泳场馆", nil]];
    }
    if(indexPath.row==1||indexPath.row ==2||indexPath.row == 6)//直接显示
    {
        static NSString *vIdentifiller = @"TrainingPlan";
        TrainingPlanTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if (!vCell)
        {
            vCell = [[TrainingPlanTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        
        [vCell.mImage setImage:[UIImage imageNamed:vButton[indexPath.row-1]]];
        vCell.mTitle.text = vTitle[indexPath.row-1];
        switch (indexPath.row)
        {
            case 1:
                [vCell.mData setText:self.mInitData[@"endTime"] ];
                break;
            case 2:
                [vCell.mData setText:[self.mInitData[@"eventId"] stringValue]];
                break;
            case 6:
                [vCell.mData setText:self.mInitData[@"swimmingPoolName"]];
                break;
            default:
                break;
        }
        return vCell;
        
        
    }
    else if(indexPath.row>=3&&indexPath.row<=5)//有排名
    {
        static NSString *vIdentifiller = @"Paiming";
        PaimingTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if (!vCell)
        {
            vCell = [[PaimingTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        
        [vCell.mImage setImage:[UIImage imageNamed:vButton[indexPath.row-1]]];
        vCell.mTitle.text = vTitle[indexPath.row-1];
        NSString * vAllRanking = [NSString stringWithFormat:@"/%@", self.mInitData[@"placeTotal"]];
        switch (indexPath.row)
        {
            case 3:
                [vCell.mMyRanking setText: [self.mInitData[@"placeD"] stringValue]];
                [vCell.mAllRanking setText:vAllRanking];
                break;
            case 4:
                [vCell.mMyRanking setText:[self.mInitData[@"placeT"] stringValue]];
                [vCell.mAllRanking setText:vAllRanking];
            case 5:
                [vCell.mMyRanking setText:[self.mInitData[@"placeC"] stringValue]];
               [vCell.mAllRanking setText:vAllRanking];
            default:
                break;
        }
        return vCell;

    
    }
    else if(indexPath.row == 7||indexPath.row == 0)//灰条
    {
        static NSString * vIdentifiller = @"gray";
        UITableViewCell * vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if(!vCell)
        {
            vCell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        return  vCell;
        
    }
    else//分项排名
    {
        static NSString *vIdentifiller = @"ThreeLabel";
        ThreeLabelTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller];
        if (!vCell)
        {
            vCell = [[ThreeLabelTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller];
        }
        NSArray * vTitle = [[NSArray alloc] initWithObjects:@"25m",@"50m",@"100m",@"200m",@"400m",@"800m",@"1000m",@"1500m", nil];
        
        vCell.mTitle.text = vTitle[indexPath.row-8];
        [vCell.mAllRanking setText:[NSString stringWithFormat:@"/%@", self.mInitData[@"placeTotal"]]];
        switch (indexPath.row)
        {
            case 8:
                [vCell.mMyRanking setText:[self.mInitData[@"place25"] stringValue]];
                break;
            case 9:
                [vCell.mMyRanking setText:[self.mInitData[@"place50"] stringValue]];
                break;
            case 10:
                [vCell.mMyRanking setText:[self.mInitData[@"place100"] stringValue]];
                break;
            case 11:
                [vCell.mMyRanking setText:[self.mInitData[@"place200"] stringValue]];
                break;
            case 12:
                [vCell.mMyRanking setText:[self.mInitData[@"place400"] stringValue]];
                break;
            case 13:
                [vCell.mMyRanking setText:[self.mInitData[@"place800"] stringValue]];
                break;
            case 14:
                [vCell.mMyRanking setText:[self.mInitData[@"place1000"] stringValue]];
                break;
            case 15:
                [vCell.mMyRanking setText:[self.mInitData[@"place1500"] stringValue]];
                break;
            default:
                break;
        }
        return vCell;
        
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
