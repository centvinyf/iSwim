//
//  PointBaseClass.h
//
//  Created by MagicBeans2  on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PointBaseClass : NSObject <NSCoding, NSCopying>
/**
 *  返回字段中的id
 */
@property (nonatomic, assign) double internalBaseClassIdentifier;
/**
 *  修改日期
 */
@property (nonatomic, strong) NSString *changeDt;
/**
 *  创建日期
 */
@property (nonatomic, strong) NSString *createdDt;
/**
 *  描述
 */
@property (nonatomic, strong) NSString *descr;
/**
 *  改变值
 */
@property (nonatomic, assign) double change;
/**
 *  修改日期
 */
@property (nonatomic, strong) NSString *modifiedDt;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
