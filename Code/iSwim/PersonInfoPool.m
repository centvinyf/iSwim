//
//  PersonInfoPool.m
//
//  Created by MagicBeans2  on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PersonInfoPool.h"


NSString *const kPersonInfoPoolCode = @"code";
NSString *const kPersonInfoPoolCreatedDt = @"createdDt";
NSString *const kPersonInfoPoolLength = @"length";
NSString *const kPersonInfoPoolModifiedDt = @"modifiedDt";
NSString *const kPersonInfoPoolName = @"name";


@interface PersonInfoPool ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PersonInfoPool

@synthesize code = _code;
@synthesize createdDt = _createdDt;
@synthesize length = _length;
@synthesize modifiedDt = _modifiedDt;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.code = [self objectOrNilForKey:kPersonInfoPoolCode fromDictionary:dict];
            self.createdDt = [self objectOrNilForKey:kPersonInfoPoolCreatedDt fromDictionary:dict];
            self.length = [[self objectOrNilForKey:kPersonInfoPoolLength fromDictionary:dict] doubleValue];
            self.modifiedDt = [self objectOrNilForKey:kPersonInfoPoolModifiedDt fromDictionary:dict];
            self.name = [self objectOrNilForKey:kPersonInfoPoolName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.code forKey:kPersonInfoPoolCode];
    [mutableDict setValue:self.createdDt forKey:kPersonInfoPoolCreatedDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.length] forKey:kPersonInfoPoolLength];
    [mutableDict setValue:self.modifiedDt forKey:kPersonInfoPoolModifiedDt];
    [mutableDict setValue:self.name forKey:kPersonInfoPoolName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.code = [aDecoder decodeObjectForKey:kPersonInfoPoolCode];
    self.createdDt = [aDecoder decodeObjectForKey:kPersonInfoPoolCreatedDt];
    self.length = [aDecoder decodeDoubleForKey:kPersonInfoPoolLength];
    self.modifiedDt = [aDecoder decodeObjectForKey:kPersonInfoPoolModifiedDt];
    self.name = [aDecoder decodeObjectForKey:kPersonInfoPoolName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_code forKey:kPersonInfoPoolCode];
    [aCoder encodeObject:_createdDt forKey:kPersonInfoPoolCreatedDt];
    [aCoder encodeDouble:_length forKey:kPersonInfoPoolLength];
    [aCoder encodeObject:_modifiedDt forKey:kPersonInfoPoolModifiedDt];
    [aCoder encodeObject:_name forKey:kPersonInfoPoolName];
}

- (id)copyWithZone:(NSZone *)zone
{
    PersonInfoPool *copy = [[PersonInfoPool alloc] init];
    
    if (copy) {

        copy.code = [self.code copyWithZone:zone];
        copy.createdDt = [self.createdDt copyWithZone:zone];
        copy.length = self.length;
        copy.modifiedDt = [self.modifiedDt copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
