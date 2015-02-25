//
//  UserProfile.h
//  iSwim
//
//  Created by MagicBeans2 on 15/2/9.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonInfoBaseClass.h"
@interface UserProfile : NSObject


@property (strong, nonatomic)PersonInfoBaseClass* mPersonInfo;
+(instancetype)manager;
@end
