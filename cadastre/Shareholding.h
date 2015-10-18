//
//  Ownership.h
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Owner.h"

@interface Shareholding : NSObject

@property (strong, nonatomic) Owner *owner;

@end
