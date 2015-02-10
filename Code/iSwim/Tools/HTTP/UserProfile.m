//
//  UserProfile.m
//  iSwim
//
//  Created by MagicBeans2 on 15/2/9.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "UserProfile.h"
static UserProfile *__manager;
@implementation UserProfile

+(instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager=[[UserProfile alloc]init];
    });
    return __manager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager=[super allocWithZone:zone];
    });
    return __manager;
}

@end
