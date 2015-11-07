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

#define kHomeDirectory          @"Documents"
#define kCitizensCSVFile        @"citizens.csv"
#define kPropertiesCSVFile      @"properties.csv"
#define kAreasCSVFile           @"areas.csv"
#define kListsCSVFile           @"lists.csv"

static NSInteger const propertiesInList = 5;
static NSInteger const ownersInList = 3;
static NSInteger const listsInArea = 2;
static NSInteger const areas = 20;

@interface Cadastre : NSObject

+ (Cadastre *)sharedCadastre;

#pragma mark - Insertions

- (BOOL)addCitizen:(Citizen *)citizen;

- (BOOL)addCitizenWithBirthNumber:(NSString *)birthNumber
                             name:(NSString *)name
                          surname:(NSString *)surname;

- (BOOL)addCadastreAreaWithNumber:(NSInteger)number
                             name:(NSString *)name;

- (BOOL)addCadastreArea:(CadastreArea *)area;

- (BOOL)addProperty:(NSNumber *)propertyNumber
     toPropertyList:(PropertyList *)list
     inCadastreArea:(CadastreArea *)area;

- (BOOL)setShareholdingToCitizen:(NSString *)birthNumber
                  toPropertyList:(PropertyList *)propertyList;

#pragma mark - Updates

- (BOOL)changePermanentAddressOfOwner:(Citizen *)owner
                           toProperty:(Property *)property;

- (BOOL)changeOwner:(Citizen *)owner
         ofProperty:(Property *)property
         toNewOwner:(Citizen *)newOwner;

#pragma mark - Fetches

- (Citizen *)citizenByBirthNumber:(NSString *)birthNumber;

- (CadastreArea *)areaByNumber:(NSNumber *)number;

- (CadastreArea *)areaByName:(NSString *)name;

- (Property *)propertyByNumber:(NSNumber *)number
                inCadastreArea:(CadastreArea *)area;

- (NSArray *)cadastreAreas;

- (NSArray *)propertiesInCadastreArea:(CadastreArea *)area;

- (NSArray *)propertiesOfOwner:(NSString *)birthNumber;

- (NSArray *)propertiesOfOwner:(Citizen *)owner
                inCadastreArea:(CadastreArea *)area;

- (PropertyList *)propertyListByNumber:(NSNumber *)number
                        inCadastreArea:(CadastreArea *)area;

- (NSArray *)citizensWithPermaAddress:(NSNumber *)propertyNumber
                       inCadastreArea:(CadastreArea *)area;

#pragma mark - Deletions

- (BOOL)removeCitizenByBirthNumber:(NSString *)birthNumber;

- (BOOL)removeProperty:(Property *)property
      fromPropertyList:(PropertyList *)propertyList
        inCadastreArea:(CadastreArea *)cadastreArea;

- (BOOL)removeCadastreArea:(CadastreArea *)area
           andMoveAgendaTo:(CadastreArea *)newArea;

- (BOOL)removePropertyList:(PropertyList *)oldList
          fromCadastreArea:(CadastreArea *)area
                 toNewList:(PropertyList *)newList;

#pragma mark - CSV

- (void)exportToCSV;

- (BOOL)importFromCSV;

#pragma mark - Misc

- (void)generateData;


@end
