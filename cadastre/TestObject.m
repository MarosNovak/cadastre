//
//  TestNode.m
//  DataStructures
//
//  Created by Maros Novák on 08/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "TestObject.h"

static NSString const *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

@implementation TestObject

- (id)initWithData:(NSString *)data
{
    if (self == [super init]) {
        self.data = data;
    }
    return self;
}

+ (TestObject *)objectWithRandomData
{
    NSMutableString *randomString =[NSMutableString stringWithCapacity:4];
    
    for (NSUInteger i = 0; i < 2; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return [[TestObject alloc] initWithData:randomString];
}

- (NSComparisonResult)compare:(id)other
{
    if ([other isKindOfClass:[TestObject class]]) {
        return [self.data compare:((TestObject *)other).data];
    }
    return -2;
}

@end
