//
//  BSTree.m
//  DataStructures
//
//  Created by Maros Novák on 03/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "BSTree.h"

@implementation BSTree

- (instancetype)initWithFirstObject:(id <BSNodeData>)object
{
    if (self == [super init]) {
        _root = [[BSNode alloc] initWithData:object];
    }
    return self;
}

- (BOOL)addObject:(id<BSNodeData>)object;
{
    BSNode *node = [[BSNode alloc] initWithData:object];
    return [self add:node];
}

- (BOOL)add:(BSNode *)node
{
    if (!self.root) {
        self.root = node;
        NSLog(@"Node added as root");
        return YES;
    }
    BSNode *actualNode = self.root;
    
    do {
        if ([actualNode compare:node] < 0) {
            if (!actualNode.rightChild) {
                actualNode.rightChild = node;
                NSLog(@"Node added as a right child");
                return YES;
            } else {
                actualNode = actualNode.rightChild;
            }
        } else if ([actualNode compare:node] >= 0) {
            // aktualny je vacsi ako porovnavany
            if (!actualNode.leftChild) {
                actualNode.leftChild = node;
                NSLog(@"Node added as a left child");
                return YES;
            } else {
                actualNode = actualNode.leftChild;
            }
        }
    } while (YES);
}

- (BOOL)remove:(BSNode *)node
{
    if (!self.root) {
        NSLog(@"Tree is empty");
        return NO;
    }

    BSNode *parent = [self findParent:node];
    
    if (parent) {
        if ([parent.leftChild compare:node] == 0) {
            parent.leftChild = [self findReplacementForNode:node];
            if (parent.leftChild) {
                parent.leftChild.leftChild = node.leftChild;
                parent.leftChild.rightChild = node.rightChild;
            }
            NSLog(@"Node was removed in left subtree");
            return YES;
        } else {
            parent.rightChild = [self findReplacementForNode:node];
            if (parent.rightChild) {
                parent.rightChild.leftChild = node.leftChild;
                parent.rightChild.rightChild = node.rightChild;
            }
            NSLog(@"Node was removed in right subtree");
            return YES;
        }
    } else {
        if ([parent compare:self.root] == 0) {
            BSNode *rootReplacement = [self findReplacementForNode:node];
            
            rootReplacement.leftChild = self.root.leftChild;
            rootReplacement.rightChild = self.root.rightChild;
            self.root = rootReplacement;
            
            NSLog(@"Root removed");
            return YES;
        } else {
            NSLog(@"Node not found");
        }
    }
    
    return NO;
}

- (BSNode *)findParent:(BSNode *)node
{
    if ([self.root compare:node] == 0) {
        NSLog(@"Node is root");
        return nil;
    }
    BSNode *actualNode = self.root;
    
    do {
        if ((actualNode.leftChild && [actualNode.leftChild compare:node] == 0) ||
            (actualNode.rightChild && [actualNode.rightChild compare:node] == 0)) {
            return actualNode;
        } else {
            if ([actualNode compare:node] < 0) {
                actualNode = actualNode.rightChild;
            } else {
                actualNode = actualNode.leftChild;
            }
        }
    } while (YES);
}

- (BSNode *)findReplacementForNode:(BSNode *)node
{
    BSNode *replacement = [self largestNodeInLeftSubtree:node];
    return replacement ? replacement : [self smallestNodeInRightSubtree:node];
}

- (BSNode *)largestNodeInLeftSubtree:(BSNode *)parent
{
    if (parent) {
        BSNode *child = parent.leftChild;
        if (child) {
            if (parent.leftChild.rightChild) {
                while (child.rightChild) {
                    parent = child;
                    child = child.rightChild;
                }
                parent.rightChild = child.leftChild;
            } else {
                child = parent.leftChild;
                parent.leftChild = child.leftChild;
            }
            return child;
        } else return nil;
    } else return nil;
}

- (BSNode *)smallestNodeInRightSubtree:(BSNode *)parent
{
    if (parent) {
        BSNode *child = parent.rightChild;
        if (child) {
            if (parent.rightChild.leftChild) {
                while (child.leftChild) {
                    parent = child;
                    child = child.leftChild;
                }
                parent.leftChild = child.rightChild;
            } else {
                child = parent.rightChild;
                parent.rightChild = child.rightChild;
            }
            return child;
        } else return nil;
    } else return nil;
}

- (BOOL)removeObject:(id<BSNodeData>)object
{
    BSNode *nodeToRemove = [self findNodeWithData:object];
    if (nodeToRemove) {
        return [self remove:nodeToRemove];
    } else {
        return NO;
    }
}

- (BSNode *)findNodeWithData:(id<BSNodeData>)data
{
    BSNode *node = [BSNode nodeWithData:data];
    BSNode *actual = self.root;
    
    do {
        if (!actual) {
            NSLog(@"Node not found");
            return nil;
        }
        
        if ([actual compare:node] > 0) {
            actual = actual.leftChild;
        }
        else if ([actual compare:node] < 0) {
            actual = actual.rightChild;
        }
        else {
            return actual;
        }
    } while (YES);
}

- (id<BSNodeData>)findObject:(id<BSNodeData>)object;
{
    BSNode *node = [[BSNode alloc] initWithData:object];
    
    return [self find:node].data;
}

- (BSNode *)find:(BSNode *)node
{
    BSNode *actual = self.root;
    
    do {
        if (!actual) {
            NSLog(@"Node not found");
            return nil;
        }
        if ([actual compare:node] > 0) {
            actual = actual.leftChild;
        } else if ([actual compare:node] < 0) {
            actual = actual.rightChild;
        } else {
            NSLog(@"Node found");
            return actual;
        }
    } while (YES);
}

- (NSUInteger)count
{
    return [self countNode:self.root];
}

- (NSUInteger)countNode:(BSNode *)node
{
    if (!node) return 0;
    
    NSUInteger count = 1;
    if (node.leftChild) count += [self countNode:node.leftChild];
    if (node.rightChild) count += [self countNode:node.rightChild];
    
    return count;
}

@end
