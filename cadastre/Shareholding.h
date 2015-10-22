//
//  Ownership.h
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Citizen.h"

@interface Shareholding : NSObject

@property (strong, nonatomic) Citizen *owner;
@property (strong, nonatomic) NSNumber *share;

+ (Shareholding *)shareholdingWithOwner:(Citizen *)owner share:(NSNumber *)share;

@end
