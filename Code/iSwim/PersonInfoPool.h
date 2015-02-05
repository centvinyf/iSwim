//
//  PersonInfoPool.h
//
//  Created by MagicBeans2  on 15/2/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PersonInfoPool : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *createdDt;
@property (nonatomic, assign) double length;
@property (nonatomic, strong) NSString *modifiedDt;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
