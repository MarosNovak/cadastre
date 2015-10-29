//
//  NSNumber+Random.m
//  cadastre
//
//  Created by Maros Novák on 28/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "NSNumber+Random.h"

#define MAX_VALUE 1000000

@implementation NSNumber (Random)

+ (NSNumber *)random
{
    return [NSNumber numberWithInt:(arc4random() % MAX_VALUE + 1)];
}

@end
