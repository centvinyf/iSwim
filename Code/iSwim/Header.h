//
//  Header.h
//  iSwim
//
//  Created by MagicBeans2 on 15/2/3.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//
#import "HttpJsonManager.h"
#import "UserProfile.h"
#ifndef iSwim_Header_h
#define iSwim_Header_h

#define SERVERADDRESS @"http://54.172.152.115:9000"
#define ALERT(msg) UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
[alert show];
#endif
