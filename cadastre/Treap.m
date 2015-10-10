//
//  Treap.m
//  DataStructures
//
//  Created by Maros Novák on 07/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Treap.h"
#import "TestNode.h"

@implementation Treap

#pragma mark - Insertion

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
//            NSLog(@"Right rotation");
            [self rightRotation:(TreapNode *)node.parent];
        } else {
//            NSLog(@"Left rotation");
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
        
        [levelOrderArray addObject:current];
        
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

+ (void)generateTest
{
    Treap *treap = [Treap new];
    
    for (int i = 1; i < 1000000; i++) {
        [treap add:[TreapNode nodeWithData:[TestNode nodeWithData]]];
    }
    
    NSArray *array = [treap inOrderTraversalForNode:treap.root];
    for (TreapNode *node in array) {
        NSLog(@"%d, %@",node.priority, ((TestNode *)node.data).data);
    }
    NSArray *level = [treap levelOrderTraversal];
    for (TreapNode *node in level) {
        NSLog(@"%d, %@",node.priority, ((TestNode *)node.data).data);
    }
//    v jednom cykle s random hodnotami
//    50/50 mazanie vkladanie
//    funkcia skontroluj stukturu - paralelne vkladat do inej nativnej struktury
//    prvky musia mat inorder prehliadku - musi byt rastuce prvky
//    SKontrolovat priority v treap strome
}

@end
