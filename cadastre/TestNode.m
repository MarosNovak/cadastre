//
//  TestNode.m
//  DataStructures
//
//  Created by Maros Novák on 08/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "TestNode.h"

static NSString const *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

@implementation TestNode

- (id)initWithData:(NSString *)data
{
    if (self == [super init]) {
        self.data = data;
    }
    return self;
}

+ (TestNode *)nodeWithData
{
    NSMutableString *randomString =[NSMutableString stringWithCapacity:4];
    
    for (int i = 0; i < 4; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return [[TestNode alloc] initWithData:randomString];
}

- (NSComparisonResult)compare:(id)other
{
    if ([other isKindOfClass:[TestNode class]]) {
        return [self.data compare:((TestNode *)other).data];
    }
    return -2;
}

@end
