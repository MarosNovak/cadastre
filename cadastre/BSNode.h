//
//  BSNode.h
//  DataStructures
//
//  Created by Maros Novák on 03/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSNodeData.h"

@interface BSNode : NSObject

@property (nonatomic, strong) id<BSNodeData> data;

@property (nonatomic, strong) BSNode *leftChild;
@property (nonatomic, strong) BSNode *rightChild;
@property (nonatomic, strong) BSNode *parent;

- (id)initWithData:(id<BSNodeData>)data;

- (NSComparisonResult)compare:(BSNode *)other;

@end
