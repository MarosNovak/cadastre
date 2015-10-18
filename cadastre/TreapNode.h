//
//  TreapNode.h
//  DataStructures
//
//  Created by Maros Novák on 07/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "BSNode.h"
#import "BSNodeData.h"

@interface TreapNode : BSNode

+ (TreapNode *)nodeWithData:(id<BSNodeData>)data;

- (id)initWithData:(id<BSNodeData>)data priority:(NSInteger)priority;

@property (nonatomic) NSInteger priority;

- (NSString *)values;

- (NSInteger)generatePriority;

@end
