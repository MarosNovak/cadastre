//
//  Property.h
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CadastreArea, PropertyList;

@interface Property : NSObject

@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *desc;

@property (strong, nonatomic) CadastreArea *area;
@property (strong, nonatomic) PropertyList *propertyList;

@end
