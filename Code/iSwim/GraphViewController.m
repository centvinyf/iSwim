//
//  GraphViewController.m
//  iSwim
//
//  Created by Magic Beans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "GraphViewController.h"
#import "MBLineChart.h"
#import "HttpJsonManager.h"
@interface GraphViewController ()

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *chartView = [MBLineChart giveMeAGraphForType:@"总成绩"
                               yValues:@[@60.1, @160.1, @126.4, @262.2, @186.2, @127.2, @176.2,@127.2, @176.2]
                      xValues:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]
                        frame:CGRectMake(0, 0, 320, 300)
                     delegate:self];
    [self.view addSubview:chartView];

}

- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{};
    [HttpJsonManager postWithParameters:parameters
                                 sender:self url:url
                      completionHandler:^(BOOL sucess, id content)
    {
        if (sucess) {
            NSLog(@"%@",content);
        }
    }];
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

@end
