//
//  PropertyList.h
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSNodeData.h"
#import "Citizen.h"
#import "Property.h"
#import "CadastreArea.h"

@class CadastreArea, Property;

@interface PropertyList : NSObject <BSNodeData>

@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) CadastreArea *area;

@property (strong, nonatomic) NSMutableArray *properties;
@property (strong, nonatomic) NSMutableArray *shareholdings;

- (id)initWithNumber:(NSNumber *)number cadastreArea:(CadastreArea *)area;
+ (PropertyList *)propertyListWithCadastreArea:(CadastreArea *)area;
+ (PropertyList *)propertyListWithNumber:(NSNumber *)number inCadastreArea:(CadastreArea *)area;

- (BOOL)addOwnerWithEqualShare:(Citizen *)owner;

- (BOOL)addProperty:(Property *)property;

- (BOOL)removeOwner:(Citizen *)owner;
- (void)removeProperty:(Property *)property;

@end
