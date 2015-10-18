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

#define MAX_VALUE 10000
#define TEST_ADD_COUNT 2000
#define TEST_REMOVE_COUNT 500

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
            NSLog(@"This node already exists");
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

+ (void)removeTest
{
    Treap *treap = [Treap new];

    TestObject *obj1 = [[TestObject alloc] initWithData:@"G"];
    TreapNode *node1 = [[TreapNode alloc] initWithData:obj1 priority:40];
    [treap add:node1];
    
    TestObject *obj2 = [[TestObject alloc] initWithData:@"E"];
    TreapNode *node2 = [[TreapNode alloc] initWithData:obj2 priority:69];
    [treap add:node2];
    TestObject *obj3 = [[TestObject alloc] initWithData:@"X"];
    TreapNode *node3 = [[TreapNode alloc] initWithData:obj3 priority:50];
    [treap add:node3];
    TestObject *obj4 = [[TestObject alloc] initWithData:@"B"];
    TreapNode *node4 = [[TreapNode alloc] initWithData:obj4 priority:77];
    [treap add:node4];
    TestObject *obj5 = [[TestObject alloc] initWithData:@"F"];
    TreapNode *node5 = [[TreapNode alloc] initWithData:obj5 priority:84];
    [treap add:node5];
    TestObject *obj6 = [[TestObject alloc] initWithData:@"C"];
    TreapNode *node6 = [[TreapNode alloc] initWithData:obj6 priority:79];
    [treap add:node6];
    TestObject *obj7 = [[TestObject alloc] initWithData:@"A"];
    TreapNode *node7 = [[TreapNode alloc] initWithData:obj7 priority:99];
    [treap add:node7];
    
    TestObject *obj8 = [[TestObject alloc] initWithData:@"M"];
    TreapNode *node8 = [[TreapNode alloc] initWithData:obj8 priority:67];
    [treap add:node8];
    
    TestObject *obj9 = [[TestObject alloc] initWithData:@"Z"];
    TreapNode *node9 = [[TreapNode alloc] initWithData:obj9 priority:90];
    [treap add:node9];
    TestObject *obj10 = [[TestObject alloc] initWithData:@"K"];
    TreapNode *node10 = [[TreapNode alloc] initWithData:obj10 priority:70];
    [treap add:node10];
    TestObject *obj11 = [[TestObject alloc] initWithData:@"P"];
    TreapNode *node11 = [[TreapNode alloc] initWithData:obj11 priority:72];
    [treap add:node11];

    [treap remove:node1];
    
    NSArray *level = [treap levelOrderTraversal];
    for (TreapNode *node in level) {
        NSLog(@"%ld, %@",(long)node.priority, ((TestObject *)node.data).data);
    }
    
    NSArray *array = [treap inOrderTraversalForNode:treap.root];
    for (TreapNode *node in array) {
        NSLog(@"%ld, %@",(long)node.priority, ((TestObject *)node.data).data);
    }
}

+ (void)generateTest
{
    Treap *treap = [Treap new];

    NSUInteger added = 0;
    for (int i = 0; i < TEST_ADD_COUNT; i++) {
        if ([treap add:[TreapNode nodeWithData:[TestObject objectWithRandomData]]]) added++;
    }
    
    NSUInteger removed = 0;
    NSUInteger count = added;
    for (int i = 0; i < TEST_REMOVE_COUNT; i++) {
        TreapNode *node = (TreapNode *)[treap find:[TreapNode nodeWithData:[TestObject objectWithRandomData]]];
        if (node) {
            [treap remove:node];
            removed++;
            count--;
        }
    }
    
    NSLog(@"%lu nodes added, %lu nodes removed, %lu was already in tree, %lu not found in tree", (unsigned long)added, (unsigned long)removed, TEST_ADD_COUNT - added, TEST_REMOVE_COUNT - removed);
    
    NSLog(@"Tree count: %ld", [treap count]);
    
    if (added - removed == [treap count]) {
        NSLog(@"Test OK");
    } else {
        NSLog(@"Test FAILED");
    }
    
//    v jednom cykle s random hodnotami
//    50/50 mazanie vkladanie
//    funkcia skontroluj stukturu - paralelne vkladat do inej nativnej struktury
//    prvky musia mat inorder prehliadku - musi byt rastuce prvky
//    SKontrolovat priority v treap strome
}

@end
