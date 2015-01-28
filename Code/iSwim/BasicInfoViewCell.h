//
//  BasicInfoViewCell.h
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInfoViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mTitle;
@property (weak, nonatomic) IBOutlet UILabel *mData;
@property (weak, nonatomic) IBOutlet UIImageView *mImage;

@end
