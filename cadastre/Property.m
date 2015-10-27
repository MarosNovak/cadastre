//
//  Property.m
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Property.h"
#import "NSString+Random.h"

static NSInteger propertyNumber = 0;

@implementation Property

+ (Property *)propertyWithNumber:(NSNumber *)number inCadastreArea:(CadastreArea *)area
{
    return [[Property alloc] initWithNumber:number cadastreArea:area];
}

+ (Property *)propertyWithCadastreArea:(CadastreArea *)area
{
    return [[Property alloc] initWithNumber:[NSNumber numberWithInteger:propertyNumber++]
                               cadastreArea:area];
}

- (id)initWithNumber:(NSNumber *)number
        cadastreArea:(CadastreArea *)area
{
    if (self == [super init]) {
        _number = number;
        _area = area;
        _address = [NSString largeRandom];
    }
    return self;
}

- (NSComparisonResult)compare:(id)other
{
    return [self.number compare:((Property *)other).number];
}

#warning dorobit format pre property

- (NSString *)CSVString
{
    return nil;
}

@end
