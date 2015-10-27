//
//  NSString+Random.m
//  cadastre
//
//  Created by Maros Novák on 27/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "NSString+Random.h"

static NSString const *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

@implementation NSString (Random)

+ (NSString *)shortRandom
{
    return [NSString randomStringWithSize:4];
}

+ (NSString *)mediumRandom
{
    return [NSString randomStringWithSize:8];
}

+ (NSString *)largeRandom
{
    return [NSString randomStringWithSize:12];
}

+ (NSString *)randomStringWithSize:(NSInteger)size
{
    NSMutableString *randomString =[NSMutableString stringWithCapacity:size];

    for (int i = 0; i < size; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((u_int32_t)[letters length])]];
    }
    return randomString;
}
@end
