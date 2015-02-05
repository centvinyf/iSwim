//
//  ChangeWeightAndHeightVC.h
//  iSwim
//
//  Created by MagicBeans2 on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeWeightAndHeightVC : UIViewController

@property (copy,nonatomic) void(^block)(NSDictionary*dic);
@property (assign,nonatomic) BOOL mSex;
@property (assign,nonatomic)double mHeight;
@property (assign,nonatomic)double mWeight;
@end
