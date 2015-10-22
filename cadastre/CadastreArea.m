//
//  CadastreArea.m
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CadastreArea.h"
#import "Treap.h"

@interface CadastreArea ()

@property (strong, nonatomic) Treap *properties;
@property (strong, nonatomic) Treap *propertyLists;

@end

@implementation CadastreArea

- (id)initWithNumber:(NSNumber *)number
                name:(NSString *)name
{
    if (self = [super init]) {
        _number = number;
        _name = name;
        _properties = [Treap new];
        _propertyLists = [Treap new];
    }
    return self;
}

+ (CadastreArea *)areaWithName:(NSString *)name
                        number:(NSNumber *)number
{
    return [[CadastreArea alloc] initWithNumber:number name:name];
}

+ (CadastreArea *)areaWithNumber:(NSNumber *)number
{
    return [[CadastreArea alloc] initWithNumber:number name:nil];
}

- (NSComparisonResult)compare:(id)other
{
    return [self.number compare:((CadastreArea *)other).number];
}

- (BOOL)addProperty:(Property *)property
{
    return NO;
}

- (BOOL)addPropertyListWithNumber:(NSNumber *)number
{
    PropertyList *list = [[PropertyList alloc] initWithNumber:number cadastreArea:self];
    return [self.propertyLists addObject:list];
}

- (PropertyList *)propertyListByNumber:(NSNumber *)number
{
    PropertyList *list = (PropertyList *)[self.propertyLists findObject:[PropertyList propertyListWithNumber:number inCadastreArea:self]];
    
    return list;
}

- (NSString *)CSVString
{
    return [NSString stringWithFormat:@"%ld,%@\n",(long)self.number.integerValue, self.name];
}

@end
