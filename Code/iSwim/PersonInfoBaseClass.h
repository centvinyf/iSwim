//
//  PersonInfoBaseClass.h
//
//  Created by MagicBeans2  on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersonInfoPool;

@interface PersonInfoBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *gender;
@property (nonatomic, assign) double points;
@property (nonatomic, assign) double weight;
@property (nonatomic, assign) double height;
@property (nonatomic, strong) PersonInfoPool *pool;
@property (nonatomic, assign) double grade;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *createdDt;
@property (nonatomic, strong) NSString *mobilePhone;
@property (nonatomic, strong) NSString *modifiedDt;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
