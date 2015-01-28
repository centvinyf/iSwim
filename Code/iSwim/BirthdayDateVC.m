//
//  BirthdayDateVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "BirthdayDateVC.h"

@interface BirthdayDateVC ()
@property (weak, nonatomic) IBOutlet UILabel *yearLab;
@property (weak, nonatomic) IBOutlet UILabel *monthLab;
@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet UIView *venueView;

@end

@implementation BirthdayDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _venueView.layer.masksToBounds=YES;
    _venueView.layer.cornerRadius=5;
}
- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            _yearLab.text=[NSString stringWithFormat:@"%d",[_yearLab.text integerValue]+1];
        }
            break;
        case 4:
        {
            _yearLab.text=[NSString stringWithFormat:@"%d",[_yearLab.text integerValue]-1];
        }
            break;
        case 2:
        {
            _monthLab.text=[NSString stringWithFormat:@"%d",[_monthLab.text integerValue]%12+1];
            if (_monthLab.text.intValue<10) {
                _monthLab.text=[NSString stringWithFormat:@"0%d",_monthLab.text.intValue];
            }
        }
            break;
        case 5:
        {
            _monthLab.text=[NSString stringWithFormat:@"%d",([_monthLab.text integerValue]-1)];
            if (_monthLab.text.intValue==0) {
                _monthLab.text=@"12";
            }
            if (_monthLab.text.intValue<10) {
                _monthLab.text=[NSString stringWithFormat:@"0%d",_monthLab.text.intValue];
            }
        }
            break;
        case 3:
        {
            _dayLab.text=[NSString stringWithFormat:@"%d",[_dayLab.text integerValue]%31+1];
            if (_dayLab.text.intValue<10) {
                _dayLab.text=[NSString stringWithFormat:@"0%d",_dayLab.text.intValue];
            }
        }
            break;
        case 6:
        {
            _dayLab.text=[NSString stringWithFormat:@"%d",([_dayLab.text integerValue]-1)];
            if (_dayLab.text.intValue==0) {
                _dayLab.text=@"31";
            }
            if (_dayLab.text.intValue<10) {
                _dayLab.text=[NSString stringWithFormat:@"0%d",_dayLab.text.intValue];
            }
        }
            break;
        default:
            break;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
