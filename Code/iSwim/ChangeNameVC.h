//
//  ChangeNameVC.h
//  iSwim
//
//  Created by MagicBeans2 on 15/2/3.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeNameVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mNameTextField;
@property (copy,nonatomic) void(^block)(NSDictionary*dic);
@property (copy,nonatomic) NSString*mName;
@end
