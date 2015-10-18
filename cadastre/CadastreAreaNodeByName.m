//
//  CadastreAreaNodeByName.m
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CadastreAreaNodeByName.h"
#import "CadastreArea.h"

@implementation CadastreAreaNodeByName

+ (TreapNode *)nodeWithData:(id<BSNodeData>)data
{
    return [[CadastreAreaNodeByName alloc] initWithArea:(CadastreArea *)data];
}

- (id)initWithArea:(CadastreArea *)area
{
    self = [super init];
    if (self) {
        self.data = area;
        self.priority = [self generatePriority];
    }
    return self;
}

#pragma mark - Override

- (NSComparisonResult)compare:(TreapNode *)other
{
    return [[((CadastreArea *)self.data).name lowercaseString] compare:[((CadastreArea *) other.data).name lowercaseString]];
}

@end
