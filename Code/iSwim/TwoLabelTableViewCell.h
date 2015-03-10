//
//  TwoLabelTableViewCell.h
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/28.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoLabelTableViewCell : UITableViewCell
/**
 *  左侧文字
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
/**
 *  右侧文字
 */
@property (weak, nonatomic) IBOutlet UILabel *mData;

@end
