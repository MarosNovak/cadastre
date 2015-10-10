//
//  MNNode.m
//  LinkedList
//
//  Created by Maros Novák on 29/09/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "LLNode.h"

@implementation LLNode

- (instancetype)initWithObject:(NSObject *)value
{
    if (self == [super init]) {
        _value = value;
    }
    return self;
}

@end
