//
//  NSString+Random.h
//  cadastre
//
//  Created by Maros Novák on 27/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Random)

+ (NSString *)shortRandom;

+ (NSString *)mediumRandom;

+ (NSString *)largeRandom;

+ (NSString *)randomBirthNumber;

@end
