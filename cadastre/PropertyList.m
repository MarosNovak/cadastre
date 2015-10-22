//
//  PropertyList.m
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertyList.h"
#import "Shareholding.h"

static NSInteger propertyListNumber = 0;
static NSInteger const maxShare = 100;

@implementation PropertyList

+ (PropertyList *)propertyListWithNumber:(NSNumber *)number inCadastreArea:(CadastreArea *)area
{
    return [[PropertyList alloc] initWithNumber:number cadastreArea:area];
}

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

- (NSString *)CSVString
{
    return [NSString stringWithFormat:@"%ld",(long)self.number.integerValue];
}

#pragma mark - Isnertions

- (BOOL)addOwnerWithEqualShare:(Citizen *)owner
{
    if (self.shareholdings.count == 0) {
        [self.shareholdings addObject:[Shareholding shareholdingWithOwner:owner share:@(maxShare)]];
        NSLog(@"Owner added as first shareholder with 100%% share.");
        return YES;
    }
    
    for (Shareholding *sh in self.shareholdings) {
        if (sh.owner == owner) {
            NSLog(@"Owner is already shareholder.");
            return NO;
        }
    }
    
    [self.shareholdings addObject:[Shareholding shareholdingWithOwner:owner share:@(0)]];
    double newShare = maxShare / self.shareholdings.count;
    
    for (Shareholding *sh in self.shareholdings) {
        sh.share = @(newShare);
    }
    NSLog(@"Owner added as shareholder");
    return YES;
}

- (BOOL)addProperty:(Property *)property
{
    [self.properties addObject:property];
    property.propertyList = self;
    [self.area addProperty:property];
    
    return YES;
}


- (BOOL)removeOwner:(Citizen *)owner
{
    return YES;
}

@end
