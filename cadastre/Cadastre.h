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

#pragma mark - Insertions

- (BOOL)addCitizenWithBirthNumber:(NSString *)birthNumber
                             name:(NSString *)name
                          surname:(NSString *)surname;

- (BOOL)addCadastreAreaWithNumber:(NSInteger)number
                             name:(NSString *)name;

- (BOOL)addProperty:(NSNumber *)propertyNumber
     toPropertyList:(NSNumber *)propertyListNumber
     inCadastreArea:(NSNumber *)cadastreAreaNumber;

- (BOOL)setShareholdingToCitizen:(NSString *)birthNumber
                  toPropertyList:(NSNumber *)propertyListNumber
                  inCadastreArea:(NSNumber *)cadastreAreaNumber;

#pragma mark - Updates

- (BOOL)changePermanentAddressOfOwner:(Citizen *)owner
                           toProperty:(NSNumber *)propertyNumber
                       inCadastreArea:(NSNumber *)cadastreAreaNumber;

- (BOOL)changeOwner:(NSString *)ownerNumber
         ofProperty:(NSNumber *)propertyNumber
     inCadastreArea:(NSNumber *)cadastreAreaNumber
         toNewOwner:(NSString *)newOwnerNumber;

#pragma mark - Fetches

- (Citizen *)citizenByBirthNumber:(NSString *)birthNumber;

- (CadastreArea *)areaByNumber:(NSNumber *)number;
- (CadastreArea *)areaByName:(NSString *)name;

- (Property *)propertyByNumber:(NSNumber *)number
                inCadastreArea:(CadastreArea *)area;

- (NSArray *)cadastreAreas;

#pragma mark - Deletions

- (BOOL)removeShareholdingFromOwner:(NSString *)ownerNumber
                   fromPropertyList:(NSNumber *)listNumber
                     inCadastreArea:(NSNumber *)cadastreAreaNumber;

- (BOOL)removeCitizenByBirthNumber:(NSString *)birthNumber;

- (BOOL)removeProperty:(NSNumber *)propertyNumber
      fromPropertyList:(NSNumber *)propertyListNumber
        inCadastreArea:(NSNumber *)cadastreAreaNumber;

- (BOOL)removeCadastreArea:(CadastreArea *)area
           andMoveAgendaTo:(NSNumber *)newCadastreArea;

#pragma mark - CSV

- (void)exportToCSV;
- (BOOL)importFromCSV;

@end
