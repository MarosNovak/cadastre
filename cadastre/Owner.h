//
//  DSInteger.h
//  DataStructures
//
//  Created by Maros Novák on 04/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSNodeData.h"

@interface Owner : NSObject <BSNodeData>

@property (strong, nonatomic) NSString *birthNumber;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;

@property (strong, nonatomic) NSMutableArray *propertyLists;

- (Owner *)itemWithBirthNumber:(NSString *)birthNumber
                          name:(NSString *)name
                       surname:(NSString *)surname;

@end
