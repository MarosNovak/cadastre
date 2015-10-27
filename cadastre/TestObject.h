//
//  TestNode.h
//  DataStructures
//
//  Created by Maros Novák on 08/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSNodeData.h"

@interface TestObject : NSObject <BSNodeData>

@property (nonatomic, strong) NSString *key;

- (id)initWithData:(NSString *)key;

+ (TestObject *)objectWithRandomData;

@end
