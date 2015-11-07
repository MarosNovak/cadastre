//
//  CadastreArea.h
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Treap.h"
#import "BSNodeData.h"
#import "PropertyList.h"

@interface CadastreArea : NSObject <BSNodeData>

@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Treap *properties;
@property (strong, nonatomic) Treap *propertyLists;

#pragma mark - Initalization

+ (CadastreArea *)areaWithName:(NSString *)name
                        number:(NSNumber *)number;

+ (CadastreArea *)areaWithNumber:(NSNumber *)number;

+ (CadastreArea *)areaWithName:(NSString *)name;

#pragma mark - Insertions

- (BOOL)addProperty:(Property *)property;

- (BOOL)addPropertyList:(PropertyList *)propertyList;

- (BOOL)addPropertyListWithNumber:(NSNumber *)number;

#pragma mark - Fetches

- (PropertyList *)propertyListByNumber:(NSNumber *)number;

- (Property *)propertyByNumber:(NSNumber *)number;

- (NSArray *)allProperties;

#pragma mark - Deletions

- (BOOL)removeProperty:(Property *)property;

- (BOOL)removePropertyList:(PropertyList *)list;

- (BOOL)moveAgendaToArea:(CadastreArea *)area;

#pragma mark - Misc

+ (CadastreArea *)randomData;

@end
