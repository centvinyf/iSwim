//
//  PersonInfoBaseClass.m
//
//  Created by MagicBeans2  on 15/2/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PersonInfoBaseClass.h"
#import "PersonInfoPool.h"


NSString *const kPersonInfoBaseClassName = @"name";
NSString *const kPersonInfoBaseClassPoints = @"points";
NSString *const kPersonInfoBaseClassPool = @"pool";
NSString *const kPersonInfoBaseClassModifiedDt = @"modifiedDt";
NSString *const kPersonInfoBaseClassWeight = @"weight";
NSString *const kPersonInfoBaseClassCreatedDt = @"createdDt";
NSString *const kPersonInfoBaseClassBirthday = @"birthday";
NSString *const kPersonInfoBaseClassHeight = @"height";
NSString *const kPersonInfoBaseClassMobilePhone = @"mobilePhone";
NSString *const kPersonInfoBaseClassGrade = @"grade";
NSString *const kPersonInfoBaseClassGender = @"gender";
NSString *const kPersonInfoBaseClassEmail = @"email";


@interface PersonInfoBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PersonInfoBaseClass

@synthesize name = _name;
@synthesize points = _points;
@synthesize pool = _pool;
@synthesize modifiedDt = _modifiedDt;
@synthesize weight = _weight;
@synthesize createdDt = _createdDt;
@synthesize birthday = _birthday;
@synthesize height = _height;
@synthesize mobilePhone = _mobilePhone;
@synthesize grade = _grade;
@synthesize gender = _gender;
@synthesize email = _email;


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
            self.name = [self objectOrNilForKey:kPersonInfoBaseClassName fromDictionary:dict];
            self.points = [[self objectOrNilForKey:kPersonInfoBaseClassPoints fromDictionary:dict] doubleValue];
            self.pool = [PersonInfoPool modelObjectWithDictionary:[dict objectForKey:kPersonInfoBaseClassPool]];
            self.modifiedDt = [self objectOrNilForKey:kPersonInfoBaseClassModifiedDt fromDictionary:dict];
            self.weight = [[self objectOrNilForKey:kPersonInfoBaseClassWeight fromDictionary:dict] doubleValue];
            self.createdDt = [self objectOrNilForKey:kPersonInfoBaseClassCreatedDt fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kPersonInfoBaseClassBirthday fromDictionary:dict];
            self.height = [[self objectOrNilForKey:kPersonInfoBaseClassHeight fromDictionary:dict] doubleValue];
            self.mobilePhone = [self objectOrNilForKey:kPersonInfoBaseClassMobilePhone fromDictionary:dict];
            self.grade = [[self objectOrNilForKey:kPersonInfoBaseClassGrade fromDictionary:dict] doubleValue];
            self.gender = [self objectOrNilForKey:kPersonInfoBaseClassGender fromDictionary:dict];
            self.email = [self objectOrNilForKey:kPersonInfoBaseClassEmail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kPersonInfoBaseClassName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.points] forKey:kPersonInfoBaseClassPoints];
    [mutableDict setValue:[self.pool dictionaryRepresentation] forKey:kPersonInfoBaseClassPool];
    [mutableDict setValue:self.modifiedDt forKey:kPersonInfoBaseClassModifiedDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weight] forKey:kPersonInfoBaseClassWeight];
    [mutableDict setValue:self.createdDt forKey:kPersonInfoBaseClassCreatedDt];
    [mutableDict setValue:self.birthday forKey:kPersonInfoBaseClassBirthday];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kPersonInfoBaseClassHeight];
    [mutableDict setValue:self.mobilePhone forKey:kPersonInfoBaseClassMobilePhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.grade] forKey:kPersonInfoBaseClassGrade];
    [mutableDict setValue:self.gender forKey:kPersonInfoBaseClassGender];
    [mutableDict setValue:self.email forKey:kPersonInfoBaseClassEmail];

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

    self.name = [aDecoder decodeObjectForKey:kPersonInfoBaseClassName];
    self.points = [aDecoder decodeDoubleForKey:kPersonInfoBaseClassPoints];
    self.pool = [aDecoder decodeObjectForKey:kPersonInfoBaseClassPool];
    self.modifiedDt = [aDecoder decodeObjectForKey:kPersonInfoBaseClassModifiedDt];
    self.weight = [aDecoder decodeDoubleForKey:kPersonInfoBaseClassWeight];
    self.createdDt = [aDecoder decodeObjectForKey:kPersonInfoBaseClassCreatedDt];
    self.birthday = [aDecoder decodeObjectForKey:kPersonInfoBaseClassBirthday];
    self.height = [aDecoder decodeDoubleForKey:kPersonInfoBaseClassHeight];
    self.mobilePhone = [aDecoder decodeObjectForKey:kPersonInfoBaseClassMobilePhone];
    self.grade = [aDecoder decodeDoubleForKey:kPersonInfoBaseClassGrade];
    self.gender = [aDecoder decodeObjectForKey:kPersonInfoBaseClassGender];
    self.email = [aDecoder decodeObjectForKey:kPersonInfoBaseClassEmail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kPersonInfoBaseClassName];
    [aCoder encodeDouble:_points forKey:kPersonInfoBaseClassPoints];
    [aCoder encodeObject:_pool forKey:kPersonInfoBaseClassPool];
    [aCoder encodeObject:_modifiedDt forKey:kPersonInfoBaseClassModifiedDt];
    [aCoder encodeDouble:_weight forKey:kPersonInfoBaseClassWeight];
    [aCoder encodeObject:_createdDt forKey:kPersonInfoBaseClassCreatedDt];
    [aCoder encodeObject:_birthday forKey:kPersonInfoBaseClassBirthday];
    [aCoder encodeDouble:_height forKey:kPersonInfoBaseClassHeight];
    [aCoder encodeObject:_mobilePhone forKey:kPersonInfoBaseClassMobilePhone];
    [aCoder encodeDouble:_grade forKey:kPersonInfoBaseClassGrade];
    [aCoder encodeObject:_gender forKey:kPersonInfoBaseClassGender];
    [aCoder encodeObject:_email forKey:kPersonInfoBaseClassEmail];
}

- (id)copyWithZone:(NSZone *)zone
{
    PersonInfoBaseClass *copy = [[PersonInfoBaseClass alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.points = self.points;
        copy.pool = [self.pool copyWithZone:zone];
        copy.modifiedDt = [self.modifiedDt copyWithZone:zone];
        copy.weight = self.weight;
        copy.createdDt = [self.createdDt copyWithZone:zone];
        copy.birthday = [self.birthday copyWithZone:zone];
        copy.height = self.height;
        copy.mobilePhone = [self.mobilePhone copyWithZone:zone];
        copy.grade = self.grade;
        copy.gender = [self.gender copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
    }
    
    return copy;
}


@end
