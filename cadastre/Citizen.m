//
//  DSInteger.m
//  DataStructures
//
//  Created by Maros Novák on 04/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Citizen.h"

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

- (NSComparisonResult)compare:(id)other
{
    return [self.birthNumber compare:((Citizen *)other).birthNumber];
}

@end
