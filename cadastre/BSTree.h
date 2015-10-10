//
//  BSTree.h
//  DataStructures
//
//  Created by Maros Novák on 03/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSNode.h"
#import "BSNodeData.h"

@interface BSTree : NSObject

@property (nonatomic, strong) BSNode *root;

- (BOOL)add:(BSNode *)node;

- (BOOL)remove:(BSNode *)node;

- (BSNode *)find:(BSNode *)node;

@end
