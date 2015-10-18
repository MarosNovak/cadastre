//
//  DSInteger.h
//  DataStructures
//
//  Created by Maros Novák on 04/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSNodeData.h"

@interface Citizen : NSObject <BSNodeData>

@property (strong, nonatomic) NSString *birthNumber;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;

@property (strong, nonatomic) NSMutableArray *propertyLists;

- (id)initWithBirthNumber:(NSString *)birthNumber
                     name:(NSString *)name
                  surname:(NSString *)surname;

+ (Citizen *)citizenWithBirthNumber:(NSString *)birthNumber;

+ (Citizen *)citizenWithBirthNumber:(NSString *)birthNumber
                               name:(NSString *)name
                            surname:(NSString *)surname;

#pragma mark - Misc

- (NSString *)fullName;

@end
