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

#pragma <#arguments#>

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

#pragma mark - Overrride

- (NSComparisonResult)compare:(id)other
{
    return [self.number compare:((CadastreArea *)other).number];
}


#pragma mark - Fetches

+ (CadastreArea *)areaWithName:(NSString *)name
                        number:(NSNumber *)number
{
    return [[CadastreArea alloc] initWithNumber:number name:name];
}

+ (CadastreArea *)areaWithNumber:(NSNumber *)number
{
    return [[CadastreArea alloc] initWithNumber:number name:nil];
}

+ (CadastreArea *)areaWithName:(NSString *)name
{
    return [[CadastreArea alloc] initWithNumber:nil name:name];
}

- (BOOL)addProperty:(Property *)property
{
    BOOL success = [self.properties addObject:property];
    if (success) {
        property.area = self;
        return YES;
    }
    return NO;
}

- (BOOL)removeProperty:(Property *)property
{
    return [self.properties removeObject:property];
}

- (BOOL)addPropertyListWithNumber:(NSNumber *)number
{
    PropertyList *list = [[PropertyList alloc] initWithNumber:number cadastreArea:self];
    return [self addPropertyList:list];
}

- (BOOL)addPropertyList:(PropertyList *)propertyList
{
    if ([self.propertyLists addObject:propertyList]) {
        propertyList.area = self;
        return YES;
    }
    return NO;
}

- (PropertyList *)propertyListByNumber:(NSNumber *)number
{
    PropertyList *list = (PropertyList *)[self.propertyLists findObject:[PropertyList propertyListWithNumber:number inCadastreArea:self]];
    
    return list;
}

- (Property *)propertyByNumber:(NSNumber *)number
{
    Property *property = (Property *)[self.properties findObject:[Property propertyWithNumber:number inCadastreArea:self]];
    
    return property;
}

- (BOOL)moveAgendaToArea:(CadastreArea *)area
{
    BSNode *currentNode = self.properties.root;
    while (currentNode) {
        [area addProperty:(Property *)currentNode.data];
        [self.properties remove:currentNode];
        currentNode = self.properties.root;
    }
    
    currentNode = self.propertyLists.root;
    while (currentNode) {
        [area addPropertyList:(PropertyList *)currentNode.data];
        [self.propertyLists remove:currentNode];
        currentNode = self.propertyLists.root;
    }
    
    return YES;
}


- (NSString *)CSVString
{
    return [NSString stringWithFormat:@"%ld,%@\n",(long)self.number.integerValue, self.name];
}

@end
