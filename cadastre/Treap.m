//
//  Treap.m
//  DataStructures
//
//  Created by Maros Novák on 07/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Treap.h"
#import "TestObject.h"
#import "LinkedList.h"

#define MAX_VALUE 100000
#define TEST_ADD_COUNT 100000
#define TEST_REMOVE_COUNT 50000

@implementation Treap

#pragma mark - Insertion

- (BOOL)addObject:(id<BSNodeData>)object;
{
    TreapNode *node = [[TreapNode alloc] initWithData:object];
    return [self add:node];
}

- (BOOL)add:(BSNode *)node
{
    TreapNode *newNode = (TreapNode *)node;
    
    if (!self.root) {
        self.root = newNode;
//        NSLog(@"%@",[node description]);
        return YES;
    }
    TreapNode *actualNode = (TreapNode *)self.root;
    
    do {
        if ([actualNode compare:node] < 0) {
            if (!actualNode.rightChild) {
                actualNode.rightChild = node;
                node.parent = actualNode;
//                NSLog(@"%@ added as a right child",[node description]);
                [self comparePriorities:newNode];
                return YES;
            } else {
                actualNode = (TreapNode *)actualNode.rightChild;
            }
        } else if ([actualNode compare:node] > 0) {
            // aktualny je vacsi ako porovnavany
            if (!actualNode.leftChild) {
                actualNode.leftChild = node;
                node.parent = actualNode;
//                NSLog(@"%@ added as a left child", [node description]);
                [self comparePriorities:newNode];
                return YES;
            } else {
                actualNode = (TreapNode *)actualNode.leftChild;
            }
        } else {
//            NSLog(@"This node already exists");
            return NO;
        }
    } while (YES);
    return NO;
}

- (BOOL)comparePriorities:(TreapNode *)node
{
    while (node.priority < ((TreapNode *)node.parent).priority) {
        if ([node compare:node.parent] < 0) {
            [self rightRotation:(TreapNode *)node.parent];
        } else {
            [self leftRotation:(TreapNode *)node.parent];
        }
        if (node == self.root) {
            return YES;
        }
    }
    return YES;
}

#pragma mark - Rotations

- (BOOL)leftRotation:(TreapNode *)node
{
    TreapNode *parent = (TreapNode *)node.parent;
    if (node) {
        TreapNode *newNode = (TreapNode *)node.rightChild;
        
        if (newNode) {
            node.rightChild = newNode.leftChild;
            node.rightChild.parent = node;
            newNode.leftChild = node;
            node.parent = newNode;
        } else {
            node.rightChild = nil;
        }
        if (parent) {
            if (parent.leftChild == node) {
                parent.leftChild = newNode;
                newNode.parent = parent;
            } else if (parent.rightChild == node) {
                parent.rightChild = newNode;
                newNode.parent = parent;
            } else {
                return NO;
            }
        } else {
            self.root = newNode;
            newNode.parent = nil;
        }
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)rightRotation:(TreapNode *)node
{
    TreapNode *parent = (TreapNode *)node.parent;

    if (node) {
        TreapNode *newNode = (TreapNode *)node.leftChild;

        if (newNode) {
            node.leftChild = newNode.rightChild;
            node.leftChild.parent = node;
            newNode.rightChild = node;
            node.parent = newNode;
        } else {
            node.leftChild = nil;
        }
        if (parent) {
            if (parent.rightChild == node) {
                parent.rightChild = newNode;
                newNode.parent = parent;
            } else if (parent.leftChild == node) {
                parent.leftChild = newNode;
                newNode.parent = parent;
            } else {
                return NO;
            }
        } else {
            self.root = newNode;
            newNode.parent = nil;
        }
        return YES;
    } else {
       return NO;
    }
}

#pragma mark - Deletions

- (BOOL)remove:(BSNode *)node
{
    if (!self.root) {
        NSLog(@"Tree is empty");
        return NO;
    }
    
    TreapNode *currentNode = (TreapNode *)node;
    TreapNode *parent = (TreapNode *)node.parent;
    
    while (![node isLeaf]) {
        if (node.leftChild && node.rightChild) {
            if (((TreapNode *)currentNode.leftChild).priority > ((TreapNode *)node.rightChild).priority) {
                [self leftRotation:currentNode];
            } else {
                [self rightRotation:currentNode];
            }
        } else if (node.leftChild) {
            [self rightRotation:currentNode];
        } else if (node.rightChild) {
            [self leftRotation:currentNode];
        }
        parent = (TreapNode *)currentNode.parent;
    }
    if (parent) {
        if (parent.leftChild == currentNode) {
            parent.leftChild = nil;
            return YES;
        } else if (parent.rightChild == currentNode) {
            parent.rightChild = nil;
            return YES;
        }
    } else {
        self.root = nil;
        return YES;
    }
    return NO;
}

#pragma mark - Traversals

- (NSArray *)levelOrderTraversal
{
    NSMutableArray *stack = [NSMutableArray array];
    NSMutableArray *levelOrderArray = [NSMutableArray array];
    if (self.root) [stack addObject:self.root];
    
    TreapNode *current;
    TreapNode *leftChild;
    TreapNode *rightChild;
    
    while (stack.count > 0) {
        current = (TreapNode *)[stack objectAtIndex:0];
        leftChild = (TreapNode *)current.leftChild;
        rightChild = (TreapNode *)current.rightChild;
        
        if (leftChild) [stack addObject:leftChild];
        if (rightChild) [stack addObject:rightChild];
        
        [levelOrderArray addObject:current.data];
        
        [stack removeObjectAtIndex:0];
    }
    
    return levelOrderArray;
}

- (NSArray *)inOrderTraversalForNode:(BSNode *)node
{
    if (!node) return nil;
    
    NSMutableArray *array = [NSMutableArray array];
    if (node.leftChild) [array addObjectsFromArray:[self inOrderTraversalForNode:node.leftChild]];
    [array addObject:node];
    if (node.rightChild) [array addObjectsFromArray:[self inOrderTraversalForNode:node.rightChild]];
    
    return array;
}

#pragma mark - Tests

+ (void)generateTest
{
    Treap *treap = [Treap new];
    NSMutableArray *array = [NSMutableArray new];
    
    NSUInteger added = 0;
    for (int i = 0; i < TEST_ADD_COUNT; i++) {
        TestObject *object = [TestObject objectWithRandomData];
        if ([treap add:[TreapNode nodeWithData:object]]) {
            [array addObject:object.data];
            added++;
        }
    }
    
    NSUInteger removed = 0;
    NSUInteger count = added;
    for (int i = 0; i < TEST_REMOVE_COUNT; i++) {
        TestObject *object = [TestObject objectWithRandomData];
        TreapNode *node = (TreapNode *)[treap find:[TreapNode nodeWithData:object]];
        if (node) {
            [array removeObject:object.data];
            [treap remove:node];
            removed++;
            count--;
        }
    }
    [self treapKeysTest:treap];
    
    NSLog(@"%lu nodes added, %lu nodes removed, %lu was already in tree, %lu not found in tree", (unsigned long)added, (unsigned long)removed, TEST_ADD_COUNT - added, TEST_REMOVE_COUNT - removed);
    
    NSLog(@"Tree count: %ld", [treap count]);
    
    if (added - removed == [treap count] && array.count == [treap count]) {
        NSLog(@"Test OK");
    } else {
        NSLog(@"Test FAILED");
    }
    
//    funkcia skontroluj stukturu - paralelne vkladat do inej nativnej struktury
//    SKontrolovat priority v treap strome
}

+ (void)treapKeysTest:(Treap *)treap
{
    NSArray *inOrder = [treap inOrderTraversalForNode:treap.root];
    for (TreapNode *node in inOrder) {
        NSLog(@"%ld, %@",(long)node.priority, ((TestObject *)node.data).data);
    }
}

@end
