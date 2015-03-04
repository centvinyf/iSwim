//
//  PersonInfoBaseClass.h
//
//  Created by MagicBeans2  on 15/2/13
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PersonInfoBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) double weight;
@property (nonatomic, assign) double height;
@property (nonatomic, strong) NSString *cODE;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, retain) NSString *poolName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
