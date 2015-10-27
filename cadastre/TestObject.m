//
//  TestNode.m
//  DataStructures
//
//  Created by Maros Novák on 08/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "TestObject.h"
#import "NSString+Random.h"

@implementation TestObject

- (id)initWithData:(NSString *)key
{
    if (self == [super init]) {
        self.key = key;
    }
    return self;
}

+ (TestObject *)objectWithRandomData
{
    return [[TestObject alloc] initWithData:[NSString shortRandom]];
}

- (NSComparisonResult)compare:(id)other
{
    if ([other isKindOfClass:[TestObject class]]) {
        return [self.key compare:((TestObject *)other).key];
    }
    return -2;
}

- (NSString *)CSVString
{
    return nil;
}

@end
