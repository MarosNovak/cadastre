//
//  Property.m
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Property.h"
#import "NSString+Random.h"
#import "CadastreArea.h"

static NSInteger propertyNumber = 0;

@implementation Property

- (id)initWithNumber:(NSNumber *)number
        cadastreArea:(CadastreArea *)area
{
    if (self == [super init]) {
        _number = number;
        _area = area;
        _address = [NSString largeRandom];
        _citizens = [NSMutableArray new];
    }
    return self;
}

+ (Property *)propertyWithNumber:(NSNumber *)number inCadastreArea:(CadastreArea *)area
{
    return [[Property alloc] initWithNumber:number cadastreArea:area];
}

+ (Property *)propertyWithCadastreArea:(CadastreArea *)area
{
    return [[Property alloc] initWithNumber:[NSNumber numberWithInteger:propertyNumber++]
                               cadastreArea:area];
}

- (NSComparisonResult)compare:(id)other
{
    return [self.number compare:((Property *)other).number];
}

- (NSString *)CSVString
{
    NSString *csvFormat = [NSString stringWithFormat:@"%ld,%ld,%ld,%@,%ld,",self.area.number.integerValue, self.propertyList.number.integerValue, self.number.integerValue, self.address, self.citizens.count];
    for (Citizen *citizen in self.citizens) {
        csvFormat = [csvFormat stringByAppendingString:[NSString stringWithFormat:@"%@,",citizen.birthNumber]];
    }
    csvFormat = [csvFormat stringByAppendingString:@"\n"];
    
    return csvFormat;
}

@end
