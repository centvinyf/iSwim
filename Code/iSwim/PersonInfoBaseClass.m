//
//  PersonInfoBaseClass.m
//
//  Created by MagicBeans2  on 15/2/13
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PersonInfoBaseClass.h"


NSString *const kPersonInfoBaseClassGender = @"gender";
NSString *const kPersonInfoBaseClassMobile = @"mobile";
NSString *const kPersonInfoBaseClassWeight = @"weight";
NSString *const kPersonInfoBaseClassHeight = @"height";
NSString *const kPersonInfoBaseClassCODE = @"CODE";
NSString *const kPersonInfoBaseClassGrade = @"grade";
NSString *const kPersonInfoBaseClassEmail = @"email";
NSString *const kPersonInfoBaseClassPath = @"path";
NSString *const kPersonInfoBaseClassName = @"name";


@interface PersonInfoBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PersonInfoBaseClass

@synthesize gender = _gender;
@synthesize mobile = _mobile;
@synthesize weight = _weight;
@synthesize height = _height;
@synthesize cODE = _cODE;
@synthesize grade = _grade;
@synthesize email = _email;
@synthesize path = _path;
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
            self.gender = [self objectOrNilForKey:kPersonInfoBaseClassGender fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kPersonInfoBaseClassMobile fromDictionary:dict];
            self.weight = [[self objectOrNilForKey:kPersonInfoBaseClassWeight fromDictionary:dict] doubleValue];
            self.height = [[self objectOrNilForKey:kPersonInfoBaseClassHeight fromDictionary:dict] doubleValue];
            self.cODE = [self objectOrNilForKey:kPersonInfoBaseClassCODE fromDictionary:dict];
            self.grade = [self objectOrNilForKey:kPersonInfoBaseClassGrade fromDictionary:dict];
            self.email = [self objectOrNilForKey:kPersonInfoBaseClassEmail fromDictionary:dict];
            self.path = [self objectOrNilForKey:kPersonInfoBaseClassPath fromDictionary:dict];
            self.name = [self objectOrNilForKey:kPersonInfoBaseClassName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.gender forKey:kPersonInfoBaseClassGender];
    [mutableDict setValue:self.mobile forKey:kPersonInfoBaseClassMobile];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weight] forKey:kPersonInfoBaseClassWeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kPersonInfoBaseClassHeight];
    [mutableDict setValue:self.cODE forKey:kPersonInfoBaseClassCODE];
    [mutableDict setValue:self.grade forKey:kPersonInfoBaseClassGrade];
    [mutableDict setValue:self.email forKey:kPersonInfoBaseClassEmail];
    [mutableDict setValue:self.path forKey:kPersonInfoBaseClassPath];
    [mutableDict setValue:self.name forKey:kPersonInfoBaseClassName];

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

    self.gender = [aDecoder decodeObjectForKey:kPersonInfoBaseClassGender];
    self.mobile = [aDecoder decodeObjectForKey:kPersonInfoBaseClassMobile];
    self.weight = [aDecoder decodeDoubleForKey:kPersonInfoBaseClassWeight];
    self.height = [aDecoder decodeDoubleForKey:kPersonInfoBaseClassHeight];
    self.cODE = [aDecoder decodeObjectForKey:kPersonInfoBaseClassCODE];
    self.grade = [aDecoder decodeObjectForKey:kPersonInfoBaseClassGrade];
    self.email = [aDecoder decodeObjectForKey:kPersonInfoBaseClassEmail];
    self.path = [aDecoder decodeObjectForKey:kPersonInfoBaseClassPath];
    self.name = [aDecoder decodeObjectForKey:kPersonInfoBaseClassName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_gender forKey:kPersonInfoBaseClassGender];
    [aCoder encodeObject:_mobile forKey:kPersonInfoBaseClassMobile];
    [aCoder encodeDouble:_weight forKey:kPersonInfoBaseClassWeight];
    [aCoder encodeDouble:_height forKey:kPersonInfoBaseClassHeight];
    [aCoder encodeObject:_cODE forKey:kPersonInfoBaseClassCODE];
    [aCoder encodeObject:_grade forKey:kPersonInfoBaseClassGrade];
    [aCoder encodeObject:_email forKey:kPersonInfoBaseClassEmail];
    [aCoder encodeObject:_path forKey:kPersonInfoBaseClassPath];
    [aCoder encodeObject:_name forKey:kPersonInfoBaseClassName];
}

- (id)copyWithZone:(NSZone *)zone
{
    PersonInfoBaseClass *copy = [[PersonInfoBaseClass alloc] init];
    
    if (copy) {

        copy.gender = [self.gender copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.weight = self.weight;
        copy.height = self.height;
        copy.cODE = [self.cODE copyWithZone:zone];
        copy.grade = [self.grade copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
        copy.path = [self.path copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
