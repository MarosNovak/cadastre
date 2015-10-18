//
//  TreapNode.m
//  DataStructures
//
//  Created by Maros Novák on 07/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "TreapNode.h"
#import "TestObject.h"

@implementation TreapNode

+ (TreapNode *)nodeWithData:(id<BSNodeData>)data
{
    return [[TreapNode alloc] initWithData:data];
}

- (id)initWithData:(id<BSNodeData>)data priority:(NSInteger)priority
{
    self = [super init];
    if (self) {
        self.data = data;
        self.priority = priority;
    }
    return self;
}

- (id)initWithData:(id<BSNodeData>)data
{
    self = [super init];
    if (self) {
        self.data = data;
        self.priority = [self generatePriority];
    }
    return self;
}

- (NSInteger)generatePriority
{
    return (arc4random() % 501) + 1000;
}

- (NSString *)values
{
    return [NSString stringWithFormat:@"%@, Priority: %ld",((TestObject *)self.data).data, (long)self.priority];
}

- (NSString *)description
{
    NSString *string = [NSString stringWithFormat:@"[Node %@ [parent: %@] [rightChild: %@] [leftChild:%@]",
                        [self values],
                        [((TreapNode *)self.parent) values],
                        [((TreapNode *)self.rightChild) values],
                        [((TreapNode *)self.leftChild) values]];
    
    return string;
}

@end
