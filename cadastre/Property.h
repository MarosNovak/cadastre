//
//  Property.h
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSNodeData.h"

@class CadastreArea, PropertyList;

@interface Property : NSObject <BSNodeData>

@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *address;

@property (strong, nonatomic) CadastreArea *area;
@property (strong, nonatomic) PropertyList *propertyList;
@property (strong, nonatomic) NSMutableArray *citizens;

+ (Property *)propertyWithNumber:(NSNumber *)number inCadastreArea:(CadastreArea *)area;
+ (Property *)propertyWithCadastreArea:(CadastreArea *)area;

@end
