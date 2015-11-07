//
//  DSInteger.m
//  DataStructures
//
//  Created by Maros Novák on 04/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Citizen.h"
#import "PropertyList.h"
#import "NSString+Random.h"

@implementation Citizen

- (id)initWithBirthNumber:(NSString *)birthNumber
                     name:(NSString *)name
                  surname:(NSString *)surname;
{
    if (self == [super init]) {
        self.name = name;
        self.surname = surname;
        self.birthNumber = birthNumber;
        self.propertyLists = [NSMutableArray new];
    }
    return self;
}

+ (Citizen *)citizenWithBirthNumber:(NSString *)birthNumber
{
    return [[Citizen alloc] initWithBirthNumber:birthNumber name:nil surname:nil];
}

+ (Citizen *)citizenWithBirthNumber:(NSString *)birthNumber
                               name:(NSString *)name
                            surname:(NSString *)surname
{
    return [[Citizen alloc] initWithBirthNumber:birthNumber name:name surname:surname];
}

+ (Citizen *)randomCitizen
{
    return [[Citizen alloc] initWithBirthNumber:[NSString randomBirthNumber] name:[NSString largeRandom] surname:[NSString largeRandom]];
}

#pragma mark - Override

- (NSComparisonResult)compare:(id)other
{
    return [self.birthNumber compare:((Citizen *)other).birthNumber];
}

- (NSArray *)allProperties
{
    NSMutableArray *properties = [NSMutableArray new];
    for (PropertyList *list in self.propertyLists) {
        [properties addObjectsFromArray:list.properties];
    }
    return properties;
}

#pragma mark - Misc

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (NSString *)CSVString
{
    return [NSString stringWithFormat:@"%@,%@,%@\n",self.birthNumber,self.name, self.surname];
}

@end
