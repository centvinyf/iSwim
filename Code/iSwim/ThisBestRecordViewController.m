//
//  ThisBestRecordViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "ThisBestRecordViewController.h"
#import "ThisBestDetailTableViewCell.h"
#import "ThisBestHeadTableViewCell.h"
#import "HttpJsonManager.h"

@interface ThisBestRecordViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property(weak,nonatomic) NSArray * mName;
@property(weak,nonatomic) NSArray * mScore;
@property (weak,nonatomic) NSArray * mBegin;
@property (weak,nonatomic) NSArray * mEnd;
@property(retain,nonatomic) NSDictionary * mInitData;
@property (retain,nonatomic) NSString * mCurrentEventId;
@end

@implementation ThisBestRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mInitData = [[NSDictionary alloc]init];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";
    self.navigationItem.backBarButtonItem = vReturnButtonItem;
    [self loadData:@"http://192.168.1.142:8080/swimming_app/app/client/events/best.do"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--
- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{@"eventId": self.mCurrentEventId};
    [HttpJsonManager getWithParameters:parameters
                                sender:self url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess) {
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
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        static NSString *vIdentifiller1 = @"HeadCell";
        ThisBestHeadTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller1];
        if (!vCell) {
            vCell = [[ThisBestHeadTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller1];
        }
        return vCell;
        
    }
    else{
        static NSString * vIdentifiller1 = @"DetailCell";
        ThisBestDetailTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller1];
        if (!vCell) {
            vCell = [[ThisBestDetailTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: vIdentifiller1];
        }
        NSArray * vName =[[NSArray alloc]initWithObjects:@"25m",@"50m",@"100m",@"200m",@"400m",@"800m",@"1000m",@"1500m", nil];
        vCell.mName.text = vName[indexPath.row-1];
        switch (indexPath.row) {
            case 1:
                [vCell.mScore setText:self.mInitData[@"m25BestScore"]];
                [vCell.mBegin setText:self.mInitData[@"m25StartId"]];
                [vCell.mEnd setText:self.mInitData[@"m25EndId"]];
                break;
            case 2:
                [vCell.mScore setText:self.mInitData[@"m50BestScore"]];
                [vCell.mBegin setText:self.mInitData[@"m50StartId"]];
                [vCell.mEnd setText:self.mInitData[@"m50EndId"]];
                break;
            case 3:
                [vCell.mScore setText:self.mInitData[@"m100BestScore"]];
                [vCell.mBegin setText:self.mInitData[@"m100StartId"]];
                [vCell.mEnd setText:self.mInitData[@"m100EndId"]];
                break;
            case 4:
                [vCell.mScore setText:self.mInitData[@"m200BestScore"]];
                [vCell.mBegin setText:self.mInitData[@"m200StartId"]];
                [vCell.mEnd setText:self.mInitData[@"m200EndId"]];
                break;
            case 5:
                [vCell.mScore setText:self.mInitData[@"m400BestScore"]];
                [vCell.mBegin setText:self.mInitData[@"m400StartId"]];
                [vCell.mEnd setText:self.mInitData[@"m400EndId"]];
                break;
            case 6:
                [vCell.mScore setText:self.mInitData[@"m800BestScore"]];
                [vCell.mBegin setText:self.mInitData[@"m800StartId"]];
                [vCell.mEnd setText:self.mInitData[@"m800EndId"]];
                break;
            case 7:
                [vCell.mScore setText:self.mInitData[@"m1000BestScore"]];
                [vCell.mBegin setText:self.mInitData[@"m1000StartId"]];
                [vCell.mEnd setText:self.mInitData[@"m1000EndId"]];
                break;
            case 8:
                [vCell.mScore setText:self.mInitData[@"m1500BestScore"]];
                [vCell.mBegin setText:self.mInitData[@"m1500StartId"]];
                [vCell.mEnd setText:self.mInitData[@"m1500EndId"]];
                break;
            default:
                break;
        }
//        vCell initViewWith:<#(NSString *)#> Scroe:<#(NSString *)#> StartID:<#(NSString *)#> EndID:<#(NSString *)#>
        return vCell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 88;
    }
    else
    {
        return 40;
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
