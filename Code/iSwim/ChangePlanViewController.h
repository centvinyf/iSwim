//
//  ChangePlanViewController.h
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/28.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"MBPickerView.h"
#import "TimePickerView.h"
@interface ChangePlanViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray * Number;
    NSString *CurrentTime;
    NSString *hour ;
    NSString *minute;
    NSString *second;
}
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
