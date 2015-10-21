//
//  BSNodeData.h
//  DataStructures
//
//  Created by Maros Novák on 03/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BSNodeData

- (NSComparisonResult)compare:(id)other;

- (NSString *)CSVString;
@end