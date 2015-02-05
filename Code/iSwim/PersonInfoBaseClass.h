//
//  PersonInfoBaseClass.h
//
//  Created by MagicBeans2  on 15/2/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersonInfoPool;

@interface PersonInfoBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double points;
@property (nonatomic, strong) PersonInfoPool *pool;
@property (nonatomic, strong) NSString *modifiedDt;
@property (nonatomic, assign) double weight;
@property (nonatomic, strong) NSString *createdDt;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, assign) double height;
@property (nonatomic, strong) NSString *mobilePhone;
@property (nonatomic, assign) double grade;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *email;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
