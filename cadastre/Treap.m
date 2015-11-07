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

#define TEST_ADD_COUNT 10000
#define TEST_REMOVE_COUNT 5000

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
    
    while (![currentNode isLeaf]) {
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
    
    if (self.root) {
        [stack addObject:self.root];
    }
    TreapNode *current;
    
    while (stack.count > 0) {
        current = (TreapNode *)[stack objectAtIndex:0];
        if ((TreapNode *)current.leftChild) {
            [stack addObject:(TreapNode *)current.leftChild];
        }
        if ((TreapNode *)current.rightChild) {
            [stack addObject:(TreapNode *)current.rightChild];
        }
        
        [levelOrderArray addObject:current.data];
        
        [stack removeObjectAtIndex:0];
    }
    
    return levelOrderArray;
}

- (NSArray *)inOrderTraversal
{
    NSMutableArray *stack = [NSMutableArray array];
    NSMutableArray *inOrderArray = [NSMutableArray array];

    if (self.root == nil) {
        return inOrderArray;
    }
    TreapNode *current = (TreapNode *)self.root;

    while (stack.count > 0 ||  current != nil) {
        if (current != nil) {
            [stack addObject:current];
            current = (TreapNode *)current.leftChild;
        } else {
            TreapNode *node = (TreapNode *)[stack lastObject];
            [stack removeLastObject];
            [inOrderArray addObject:node.data];
            current = (TreapNode *)node.rightChild;
        }
    }
    return inOrderArray;
}

@end
