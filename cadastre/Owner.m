//
//  DSInteger.m
//  DataStructures
//
//  Created by Maros Novák on 04/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Owner.h"

@implementation Owner

- (id)initWithBirthNumber:(NSString *)birthNumber
                     name:(NSString *)name
                  surname:(NSString *)surname;
{
    if (self == [super init]) {
        self.name = name;
        self.surname = surname;
        self.birthNumber = birthNumber;
    }
    return self;
}

- (Owner *)itemWithBirthNumber:(NSString *)birthNumber
                          name:(NSString *)name
                       surname:(NSString *)surname
{
    return [[Owner alloc] initWithBirthNumber:birthNumber name:name surname:surname];
}

- (NSComparisonResult)compare:(id)other
{
    return [self.birthNumber compare:((Owner *)other).birthNumber];
}

@end
