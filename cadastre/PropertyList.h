//
//  PropertyList.h
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CadastreArea.h"

@interface PropertyList : NSObject

@property (nonatomic) NSNumber *number;
@property (strong, nonatomic) CadastreArea *area;

@property (nonatomic) NSMutableArray *properties;
@property (nonatomic) NSMutableArray *ownerships;

@end
