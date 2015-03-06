//
//  DetailTableViewCell.h
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/3/5.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mTime;
@property (weak, nonatomic) IBOutlet UILabel *mDate;
@property (weak, nonatomic) IBOutlet UILabel *mPlace;
@property (weak, nonatomic) IBOutlet UILabel *mSingle;

@end
