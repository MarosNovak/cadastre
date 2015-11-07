//
//  Treap.h
//  DataStructures
//
//  Created by Maros Novák on 07/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "BSTree.h"
#import "TreapNode.h"

@interface Treap : BSTree

- (NSArray *)levelOrderTraversal;

- (NSArray *)inOrderTraversal;

@end
