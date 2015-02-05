//
//  ChangeEmailVC.h
//  iSwim
//
//  Created by MagicBeans2 on 15/2/3.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeEmailVC : UIViewController

@property (copy,nonatomic) void(^block)(NSDictionary*dic);
@property (copy,nonatomic) NSString*mEmail;
@end
