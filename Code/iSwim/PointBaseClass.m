//
//  PointBaseClass.m
//
//  Created by MagicBeans2  on 15/2/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PointBaseClass.h"


NSString *const kPointBaseClassId = @"id";
NSString *const kPointBaseClassChangeDt = @"changeDt";
NSString *const kPointBaseClassCreatedDt = @"createdDt";
NSString *const kPointBaseClassDescr = @"descr";
NSString *const kPointBaseClassChange = @"change";
NSString *const kPointBaseClassModifiedDt = @"modifiedDt";


@interface PointBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PointBaseClass

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize changeDt = _changeDt;
@synthesize createdDt = _createdDt;
@synthesize descr = _descr;
@synthesize change = _change;
@synthesize modifiedDt = _modifiedDt;


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
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kPointBaseClassId fromDictionary:dict] doubleValue];
            self.changeDt = [self objectOrNilForKey:kPointBaseClassChangeDt fromDictionary:dict];
            self.createdDt = [self objectOrNilForKey:kPointBaseClassCreatedDt fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kPointBaseClassDescr fromDictionary:dict];
            self.change = [[self objectOrNilForKey:kPointBaseClassChange fromDictionary:dict] doubleValue];
            self.modifiedDt = [self objectOrNilForKey:kPointBaseClassModifiedDt fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kPointBaseClassId];
    [mutableDict setValue:self.changeDt forKey:kPointBaseClassChangeDt];
    [mutableDict setValue:self.createdDt forKey:kPointBaseClassCreatedDt];
    [mutableDict setValue:self.descr forKey:kPointBaseClassDescr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.change] forKey:kPointBaseClassChange];
    [mutableDict setValue:self.modifiedDt forKey:kPointBaseClassModifiedDt];

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

    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kPointBaseClassId];
    self.changeDt = [aDecoder decodeObjectForKey:kPointBaseClassChangeDt];
    self.createdDt = [aDecoder decodeObjectForKey:kPointBaseClassCreatedDt];
    self.descr = [aDecoder decodeObjectForKey:kPointBaseClassDescr];
    self.change = [aDecoder decodeDoubleForKey:kPointBaseClassChange];
    self.modifiedDt = [aDecoder decodeObjectForKey:kPointBaseClassModifiedDt];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kPointBaseClassId];
    [aCoder encodeObject:_changeDt forKey:kPointBaseClassChangeDt];
    [aCoder encodeObject:_createdDt forKey:kPointBaseClassCreatedDt];
    [aCoder encodeObject:_descr forKey:kPointBaseClassDescr];
    [aCoder encodeDouble:_change forKey:kPointBaseClassChange];
    [aCoder encodeObject:_modifiedDt forKey:kPointBaseClassModifiedDt];
}

- (id)copyWithZone:(NSZone *)zone
{
    PointBaseClass *copy = [[PointBaseClass alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.changeDt = [self.changeDt copyWithZone:zone];
        copy.createdDt = [self.createdDt copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.change = self.change;
        copy.modifiedDt = [self.modifiedDt copyWithZone:zone];
    }
    
    return copy;
}


@end
