//
//  PersonInfoBaseClass.m
//
//  Created by MagicBeans2  on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PersonInfoBaseClass.h"
#import "PersonInfoPool.h"


NSString *const kPersonInfoBaseClassGender = @"gender";
NSString *const kPersonInfoBaseClassPoints = @"points";
NSString *const kPersonInfoBaseClassWeight = @"weight";
NSString *const kPersonInfoBaseClassHeight = @"height";
NSString *const kPersonInfoBaseClassPool = @"pool";
NSString *const kPersonInfoBaseClassGrade = @"grade";
NSString *const kPersonInfoBaseClassEmail = @"email";
NSString *const kPersonInfoBaseClassCreatedDt = @"createdDt";
NSString *const kPersonInfoBaseClassMobilePhone = @"mobilePhone";
NSString *const kPersonInfoBaseClassModifiedDt = @"modifiedDt";
NSString *const kPersonInfoBaseClassName = @"name";


@interface PersonInfoBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PersonInfoBaseClass

@synthesize gender = _gender;
@synthesize points = _points;
@synthesize weight = _weight;
@synthesize height = _height;
@synthesize pool = _pool;
@synthesize grade = _grade;
@synthesize email = _email;
@synthesize createdDt = _createdDt;
@synthesize mobilePhone = _mobilePhone;
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
            self.gender = [self objectOrNilForKey:kPersonInfoBaseClassGender fromDictionary:dict];
            self.points = [[self objectOrNilForKey:kPersonInfoBaseClassPoints fromDictionary:dict] doubleValue];
            self.weight = [[self objectOrNilForKey:kPersonInfoBaseClassWeight fromDictionary:dict] doubleValue];
            self.height = [[self objectOrNilForKey:kPersonInfoBaseClassHeight fromDictionary:dict] doubleValue];
            self.pool = [PersonInfoPool modelObjectWithDictionary:[dict objectForKey:kPersonInfoBaseClassPool]];
            self.grade = [[self objectOrNilForKey:kPersonInfoBaseClassGrade fromDictionary:dict] doubleValue];
            self.email = [self objectOrNilForKey:kPersonInfoBaseClassEmail fromDictionary:dict];
            self.createdDt = [self objectOrNilForKey:kPersonInfoBaseClassCreatedDt fromDictionary:dict];
            self.mobilePhone = [self objectOrNilForKey:kPersonInfoBaseClassMobilePhone fromDictionary:dict];
            self.modifiedDt = [self objectOrNilForKey:kPersonInfoBaseClassModifiedDt fromDictionary:dict];
            self.name = [self objectOrNilForKey:kPersonInfoBaseClassName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.gender forKey:kPersonInfoBaseClassGender];
    [mutableDict setValue:[NSNumber numberWithDouble:self.points] forKey:kPersonInfoBaseClassPoints];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weight] forKey:kPersonInfoBaseClassWeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kPersonInfoBaseClassHeight];
    [mutableDict setValue:[self.pool dictionaryRepresentation] forKey:kPersonInfoBaseClassPool];
    [mutableDict setValue:[NSNumber numberWithDouble:self.grade] forKey:kPersonInfoBaseClassGrade];
    [mutableDict setValue:self.email forKey:kPersonInfoBaseClassEmail];
    [mutableDict setValue:self.createdDt forKey:kPersonInfoBaseClassCreatedDt];
    [mutableDict setValue:self.mobilePhone forKey:kPersonInfoBaseClassMobilePhone];
    [mutableDict setValue:self.modifiedDt forKey:kPersonInfoBaseClassModifiedDt];
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
    self.points = [aDecoder decodeDoubleForKey:kPersonInfoBaseClassPoints];
    self.weight = [aDecoder decodeDoubleForKey:kPersonInfoBaseClassWeight];
    self.height = [aDecoder decodeDoubleForKey:kPersonInfoBaseClassHeight];
    self.pool = [aDecoder decodeObjectForKey:kPersonInfoBaseClassPool];
    self.grade = [aDecoder decodeDoubleForKey:kPersonInfoBaseClassGrade];
    self.email = [aDecoder decodeObjectForKey:kPersonInfoBaseClassEmail];
    self.createdDt = [aDecoder decodeObjectForKey:kPersonInfoBaseClassCreatedDt];
    self.mobilePhone = [aDecoder decodeObjectForKey:kPersonInfoBaseClassMobilePhone];
    self.modifiedDt = [aDecoder decodeObjectForKey:kPersonInfoBaseClassModifiedDt];
    self.name = [aDecoder decodeObjectForKey:kPersonInfoBaseClassName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_gender forKey:kPersonInfoBaseClassGender];
    [aCoder encodeDouble:_points forKey:kPersonInfoBaseClassPoints];
    [aCoder encodeDouble:_weight forKey:kPersonInfoBaseClassWeight];
    [aCoder encodeDouble:_height forKey:kPersonInfoBaseClassHeight];
    [aCoder encodeObject:_pool forKey:kPersonInfoBaseClassPool];
    [aCoder encodeDouble:_grade forKey:kPersonInfoBaseClassGrade];
    [aCoder encodeObject:_email forKey:kPersonInfoBaseClassEmail];
    [aCoder encodeObject:_createdDt forKey:kPersonInfoBaseClassCreatedDt];
    [aCoder encodeObject:_mobilePhone forKey:kPersonInfoBaseClassMobilePhone];
    [aCoder encodeObject:_modifiedDt forKey:kPersonInfoBaseClassModifiedDt];
    [aCoder encodeObject:_name forKey:kPersonInfoBaseClassName];
}

- (id)copyWithZone:(NSZone *)zone
{
    PersonInfoBaseClass *copy = [[PersonInfoBaseClass alloc] init];
    
    if (copy) {

        copy.gender = [self.gender copyWithZone:zone];
        copy.points = self.points;
        copy.weight = self.weight;
        copy.height = self.height;
        copy.pool = [self.pool copyWithZone:zone];
        copy.grade = self.grade;
        copy.email = [self.email copyWithZone:zone];
        copy.createdDt = [self.createdDt copyWithZone:zone];
        copy.mobilePhone = [self.mobilePhone copyWithZone:zone];
        copy.modifiedDt = [self.modifiedDt copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
