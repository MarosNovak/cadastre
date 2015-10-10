//
//  MNLinkedList.h
//  LinkedList
//
//  Created by Maros Novák on 29/09/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLNode.h"

@interface LinkedList : NSObject

- (instancetype)initWithFirstObject:(NSObject *)object;

- (void)addToFront:(NSObject *)object;
- (void)addToLast:(NSObject *)object;
- (void)addObject:(NSObject *)object atIndex:(NSInteger)index;

- (NSObject *)firstObject;
- (NSObject *)lastObject;
- (NSObject *)objectAtIndex:(NSInteger)index;

- (BOOL)removeObjectAtIndex:(NSInteger)index;

- (NSInteger)count;

@end
