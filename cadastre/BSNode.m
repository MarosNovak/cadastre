//
//  BSNode.m
//  DataStructures
//
//  Created by Maros Novák on 03/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "BSNode.h"

@implementation BSNode

- (id)initWithData:(id<BSNodeData>)data
{
    self = [super init];
    if (self) {
        _data = data;
    }
    return self;
}

- (NSComparisonResult)compare:(BSNode *)other
{
    return [self.data compare:other.data];
}

@end
