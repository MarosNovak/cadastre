//
//  CadastreArea.h
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSNodeData.h"
#import "PropertyList.h"

@interface CadastreArea : NSObject <BSNodeData>

@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *name;

+ (CadastreArea *)areaWithName:(NSString *)name
                        number:(NSNumber *)number;

+ (CadastreArea *)areaWithNumber:(NSNumber *)number;

- (BOOL)addProperty:(Property *)property;

- (BOOL)addPropertyListWithNumber:(NSNumber *)number;

- (PropertyList *)propertyListByNumber:(NSNumber *)number;

- (Property *)propertyByNumber:(NSNumber *)number;

- (BOOL)removeProperty:(Property *)property;

@end
