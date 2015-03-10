//
//  PaimingTableViewCell.h
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/28.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaimingTableViewCell : UITableViewCell
/**
 *  图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *mImage;
/**
 *  左侧文字
 */
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
/**
 *  右侧排名左半部分
 */
@property (weak, nonatomic) IBOutlet UILabel *mMyRanking;
/**
 *  右侧排名右半部分
 */
@property (weak, nonatomic) IBOutlet UILabel *mAllRanking;

@end
