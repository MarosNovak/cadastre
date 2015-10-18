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

@property (nonatomic, strong) NSString *data;

- (id)initWithData:(NSString *)data;

+ (TestObject *)objectWithRandomData;

@end
