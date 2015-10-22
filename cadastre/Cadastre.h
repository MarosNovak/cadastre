//
//  Cadastre.h
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Treap.h"
#import "Citizen.h"
#import "CadastreArea.h"

#define kHomeDirectory      @"Documents"
#define kCitizensCSVFile    @"citizens.csv"

@interface Cadastre : NSObject

+ (Cadastre *)sharedCadastre;

- (BOOL)addCitizenWithBirthNumber:(NSString *)birthNumber
                             name:(NSString *)name
                          surname:(NSString *)surname;

- (BOOL)addCadastreAreaWithNumber:(NSInteger)number
                             name:(NSString *)name;

- (BOOL)setShareholdingToCitizen:(NSString *)birthNumber
                  toPropertyList:(NSNumber *)propertyListNumber
                  inCadastreArea:(NSNumber *)cadastreAreaNumber;

- (Citizen *)citizenByBirthNumber:(NSString *)birthNumber;

- (CadastreArea *)areaByNumber:(NSNumber *)number;

- (NSArray *)cadastreAreas;

- (BOOL)removeCitizenByBirthNumber:(NSString *)birthNumber;

- (void)exportToCSV;
- (BOOL)importFromCSV;

@end
