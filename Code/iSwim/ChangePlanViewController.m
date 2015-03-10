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
{
    NSMutableArray * mNumber;
    NSString *mCurrentTime;
    NSString *mHour ;
    NSString *mMinute;
    NSString *mSecond;
}
@property (weak, nonatomic) IBOutlet UIButton *mBigConfirmButton;
@property (weak, nonatomic) IBOutlet UIButton *mTrainingDate;
@property (weak, nonatomic) IBOutlet UIButton *mTrainingTime;
@property (weak, nonatomic) IBOutlet UITextField *mTrainingChangci;
@property (weak, nonatomic) IBOutlet UITextField *mTrainingDistance;
@property (weak, nonatomic) IBOutlet UITextField *mSingle;
@property (weak, nonatomic) IBOutlet UITextField *mHot;
@property (weak, nonatomic) IBOutlet UIButton *mPlaceLabel;
@property (weak, nonatomic) IBOutlet UIButton *m25mTime;
@property (weak, nonatomic) IBOutlet UIButton *m50mTime;
@property (weak, nonatomic) IBOutlet UIButton *m100mTime;
@property (weak, nonatomic) IBOutlet UIButton *m200mTime;
@property (weak, nonatomic) IBOutlet UIButton *m400mTime;
@property (weak, nonatomic) IBOutlet UIButton *m800mTime;
@property (weak, nonatomic) IBOutlet UIButton *m1000mTime;
@property (weak, nonatomic) IBOutlet UIButton *m1500mTime;
@property (weak, nonatomic) IBOutlet UIView *mDateSetView;

@property (weak, nonatomic) IBOutlet UIView *mTimeSetView;

@property (weak, nonatomic) IBOutlet UIButton *mDateConfirm;
@property (weak, nonatomic) IBOutlet UILabel *mTimeTitle;
@property (weak, nonatomic) IBOutlet UIButton *mTimeConfirm;
@property (weak, nonatomic) IBOutlet MBPickerView *mDatePicker;
@property (weak, nonatomic) IBOutlet TimePickerView *mTimePicker;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UIView *mHideView;

@end

@implementation ChangePlanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";//改改改
    self.navigationItem.backBarButtonItem = vReturnButtonItem;
   
    self.mTimePicker.delegate = self;
    self.mTimePicker.dataSource =self;
    mHour = @"0";
    mMinute = @"0";
    mSecond = @"0";
    // Do any additional setup after loading the view.
    mNumber=[[NSMutableArray alloc]init];
    for (int i = 0; i < 60; i++)
    {
        [mNumber addObject:[NSString stringWithFormat:@"%d",i]];
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
    if (component == 2 || component == 4 || component == 0)
    {
        return [NSString stringWithFormat:@"%ld",(long)row];
    }
    else if(component == 1) return @"h";
    else if (component == 3) return @"m";
    else return @"s";
}
- (void)didReceiveMemoryWarning
{
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
    if (component == 0)
    {
        
        mHour = mNumber[row];
    }
    if (component == 2)
    {
        
        mMinute =mNumber[row];
    }
    if (component == 4)
    {
        
        mSecond =mNumber[row];
    }
    else ;
    mCurrentTime = [NSString stringWithFormat:@"%@h%@m%@s",mHour,mMinute,mSecond];;
};

- (IBAction)TimeSetConfirmButtonPressed:(id)sender
{
    
    [(UIButton *)self.mTimePicker.sender setTitle:mCurrentTime forState:UIControlStateNormal];
    self.mTimeSetView.hidden = YES;
    self.mBigConfirmButton.hidden = NO;
}

- (IBAction)mHideButtonPressed:(id)sender
{
    self.mHideView.hidden = YES;
    [self.mTrainingDistance resignFirstResponder];
    [self.mTrainingChangci resignFirstResponder];
    [self.mSingle resignFirstResponder];
    [self.mHot resignFirstResponder];
}

- (IBAction)mDateButtonPressed:(id)sender
{
    self.mDateSetView.hidden = NO;
    self.mBigConfirmButton.hidden = YES;
    self.mDatePicker.sender = sender;
    
}

- (IBAction)DateConfirmButtonPressed:(id)sender
{
    NSDateFormatter * vDataFomatter = [[NSDateFormatter alloc]init];
    [vDataFomatter setDateFormat:@"yyyy-MM-dd"];
    NSString * vDate = [vDataFomatter stringFromDate:self.mDatePicker.date];
    [self.mTrainingDate setTitle:vDate forState:UIControlStateNormal ];
    self.mDateSetView.hidden = YES;
    self.mBigConfirmButton.hidden = NO;
}

- (IBAction)mEditDidBegin:(id)sender
{
    self.mHideView.hidden = NO;
}

- (IBAction)mTimeChangeButtonPressed:(id)sender
{
    self.mTimeSetView.hidden = NO;
    self.mBigConfirmButton.hidden = YES;
    self.mTimePicker.sender = sender;
}

@end
