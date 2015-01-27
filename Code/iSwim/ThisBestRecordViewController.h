//
//  ThisBestRecordViewController.h
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThisBestRecordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property(weak,nonatomic) NSArray * Name;
@property(weak,nonatomic) NSArray * Score;
@property (weak,nonatomic) NSArray * Begin;
@property (weak,nonatomic) NSArray * End;
@end
