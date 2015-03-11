//
//  TrainingEventsTableViewCell.h
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainingEventsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mTrainingDate;
@property (weak, nonatomic) IBOutlet UILabel *mEventID;
@property (weak, nonatomic) IBOutlet UILabel *mTrainingDIs;
@property (weak, nonatomic) IBOutlet UILabel *mTrainingTime;
@property (weak, nonatomic) IBOutlet UILabel *mTrainingCal;
@property (weak, nonatomic) IBOutlet UILabel *mTrainingDanbianshu;
@property (weak, nonatomic) IBOutlet UILabel *mTrainingPool;
@property (weak, nonatomic) IBOutlet UILabel *mLeft1;
@property (weak, nonatomic) IBOutlet UILabel *mLeft2;
@property (weak, nonatomic) IBOutlet UILabel *mLeft3;
@property (weak, nonatomic) IBOutlet UILabel *mLeft5;

@end
