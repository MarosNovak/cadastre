//
//  MNNode.h
//  LinkedList
//
//  Created by Maros Novák on 29/09/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLNode : NSObject

@property (nonatomic, strong) NSObject *value;
@property (nonatomic, strong) LLNode *next;

- (instancetype)initWithObject:(NSObject *)value;

@end
