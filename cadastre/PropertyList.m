//
//  PropertyList.m
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertyList.h"

static NSInteger propertyListNumber = 0;

@implementation PropertyList

+ (PropertyList *)propertyListWithCadastreArea:(CadastreArea *)area
{
    return [[PropertyList alloc] initWithNumber:[NSNumber numberWithInteger:propertyListNumber++]
                                   cadastreArea:area];
}

- (id)initWithNumber:(NSNumber *)number
        cadastreArea:(CadastreArea *)area
{
    if (self == [super init]) {
        _number = number;
        _area = area;
        _properties = [NSMutableArray new];
        _shareholdings = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Override

- (NSComparisonResult)compare:(id)other
{
    return [self.number compare:((PropertyList *)other).number];
}

- (BOOL)addOwner:(Citizen *)owner withShare:(NSNumber *)share
{
    return YES;
}

- (BOOL)addProperty:(Property *)property
{
    return YES;
}

- (BOOL)removeOwner:(Citizen *)owner
{
    return YES;
}

@end
