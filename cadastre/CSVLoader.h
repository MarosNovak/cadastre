//
//  CSVParser.h
//  cadastre
//
//  Created by Maros Novák on 21/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSVLoader : NSObject

+ (BOOL)loadCitizens;

+ (BOOL)parseAreas;
+ (BOOL)parseCertificates;
+ (BOOL)parseProperties;
+ (BOOL)parseOwnership;

@end
