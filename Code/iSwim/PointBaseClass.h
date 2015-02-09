//
//  PointBaseClass.h
//
//  Created by MagicBeans2  on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PointBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *changeDt;
@property (nonatomic, strong) NSString *createdDt;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, assign) double change;
@property (nonatomic, strong) NSString *modifiedDt;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
