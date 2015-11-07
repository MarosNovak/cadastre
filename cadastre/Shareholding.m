//
//  Ownership.m
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Shareholding.h"
#import "Citizen.h"

@implementation Shareholding

#pragma mark - Initialization

- (id)initWithOwner:(Citizen *)owner share:(NSNumber *)share
{
    self = [super init];
    if (self) {
        self.owner = owner;
        self.share = share;
    }
    return self;
}

+ (Shareholding *)shareholdingWithOwner:(Citizen *)owner share:(NSNumber *)share
{
    return [[Shareholding alloc] initWithOwner:owner share:share];
}



@end
