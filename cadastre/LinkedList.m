//
//  MNLinkedList.m
//  LinkedList
//
//  Created by Maros Novák on 29/09/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "LinkedList.h"

@interface LinkedList ()

@property (nonatomic) NSInteger count;
@property (nonatomic, strong) LLNode *first;
@property (nonatomic, strong) LLNode *last;

@end

@implementation LinkedList

#pragma mark - Init

- (instancetype)initWithFirstObject:(NSObject *)object
{
    if (self == [super init]) {
        [self setupValuesWithObject:object];
    }
    return self;
}

- (void)setupValuesWithObject:(NSObject *)object
{
    _first = [[LLNode alloc] initWithObject:object];
    _last = _first;
    _count = 1;
}

#pragma mark - Insertions

- (void)addToFront:(NSObject *)object
{
    if (!self.first) {
        [self setupValuesWithObject:object];
        return;
    }
    
    LLNode *newNode = [[LLNode alloc] initWithObject:object];

    if (self.first == self.last) {
        self.first = newNode;
        self.first.next = self.last;
    } else {
        newNode.next = self.first;
        self.first = newNode;
    }

    self.count++;
}

- (void)addToLast:(NSObject *)object
{
    if (!self.last) {
        [self setupValuesWithObject:object];
        return;
    }
    
    LLNode *newNode = [[LLNode alloc] initWithObject:object];
    
    self.last.next = newNode;
    self.last = newNode;

    self.count++;
}

- (void)addObject:(NSObject *)object atIndex:(NSInteger)index
{
    if (index > self.count) {
        NSLog(@"Insert out of bound");
        return;
    }
    
    LLNode *newNode = [[LLNode alloc] initWithObject:object];
    LLNode *current = self.first;
    LLNode *next;
    LLNode *previous;
    
    for (NSInteger i = 1; i <= self.count; i++) {
        current = current.next;
        if (i == index - 1) {
            previous = current;
        }
        else if (i == index) {
            next = current;
        }
    }
    
    if (!previous) {
        self.first = newNode;
    } else {
        previous.next = newNode;
        newNode.next = next;
    }
    self.count++;
}

#pragma mark - Finding objects

- (NSObject *)objectAtIndex:(NSInteger)index
{
    LLNode *currentNode = self.first;
    
    for (NSInteger i = 1; i < self.count; i++) {
        currentNode = currentNode.next;
        if (i == index) {
            return currentNode.value;
        }
    }
    return nil;
}

- (NSObject *)firstObject
{
    return self.first.value;
}

- (NSObject *)lastObject
{
    return self.last.value;
}

#pragma mark - Deletions

- (BOOL)removeObjectAtIndex:(NSInteger)index
{
    if (index < 1 || index > self.count) {
        NSLog(@"Deleting index out of bound");
        return NO;
    }
    
    LLNode *current = self.first;
    
    for (NSUInteger i = 1; i < index; i++) {
        if (current.next == nil) {
            return NO;
        }
        current = current.next;
    }
    current.next = current.next.next;
    
    self.count--;
    return YES;
}

@end
