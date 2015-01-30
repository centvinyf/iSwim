//
//  ChangePlanViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/28.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "ChangePlanViewController.h"
#import "TimePickerView.h"
@interface ChangePlanViewController ()
@end

@implementation ChangePlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @" ";//改改改
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    self.mTimePicker.delegate = self;
    self.mTimePicker.dataSource =self;
    hour = @"0";
    minute = @"0";
    second = @"0";
    // Do any additional setup after loading the view.
    Number=[[NSMutableArray alloc]init];
    for (int i = 0; i < 60; i++) {
        [Number addObject:[NSString stringWithFormat:@"%d",i]];
    }

}
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 6;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0) return 24;
    else if(component == 2) return 60;
    else if(component == 1 || component == 3 || component == 5) return 1;
    else return 60;
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 2 || component == 4 || component == 0) {
        return [NSString stringWithFormat:@"%ld",(long)row];
    }
    else if(component == 1) return @"h";
    else if (component == 3) return @"m";
    else return @"s";
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        hour = Number[row];
    }
    if (component == 2) {
        
        minute =Number[row];
    }
    if (component == 4) {
        
        second =Number[row];
    }
    else ;
    CurrentTime = [NSString stringWithFormat:@"%@h%@m%@s",hour,minute,second];;
};
- (IBAction)TimeSetConfirmButtonPressed:(id)sender {
    
    [(UIButton *)self.mTimePicker.sender setTitle:CurrentTime forState:UIControlStateNormal];
    self.mTimeSetView.hidden = YES;
    self.mBigConfirmButton.hidden = NO;
}
- (IBAction)mHideButtonPressed:(id)sender {
    self.mHideView.hidden = YES;
    [self.mTrainingDistance resignFirstResponder];
    [self.mTrainingChangci resignFirstResponder];
    [self.mSingle resignFirstResponder];
    [self.mHot resignFirstResponder];
}
- (IBAction)mDateButtonPressed:(id)sender {
    self.mDateSetView.hidden = NO;
    self.mBigConfirmButton.hidden = YES;
    self.mDatePicker.sender = sender;
    
}
- (IBAction)DateConfirmButtonPressed:(id)sender {
    NSDateFormatter * DataFomatter = [[NSDateFormatter alloc]init];
    [DataFomatter setDateFormat:@"yyyy-MM-dd"];
    NSString * Date = [DataFomatter stringFromDate:self.mDatePicker.date];
    [self.mTrainingDate setTitle:Date forState:UIControlStateNormal ];
    self.mDateSetView.hidden = YES;
    self.mBigConfirmButton.hidden = NO;
}
- (IBAction)mEditDidBegin:(id)sender {
    self.mHideView.hidden = NO;
}
- (IBAction)mTimeChangeButtonPressed:(id)sender {
    self.mTimeSetView.hidden = NO;
    self.mBigConfirmButton.hidden = YES;
    self.mTimePicker.sender = sender;
}

@end
