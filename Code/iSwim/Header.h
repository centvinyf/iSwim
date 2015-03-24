//
//  Header.h
//  iSwim
//
//  Created by MagicBeans2 on 15/2/3.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//
#import "HttpJsonManager.h"
#import "UserProfile.h"
#import "NSString+MD5.h"
#ifndef iSwim_Header_h
#define iSwim_Header_h

#define SERVERADDRESS @"http://192.168.1.113:8080/"
#define ALERT(msg) UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
[alert show];
#endif
