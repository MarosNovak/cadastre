//
//  Cadastre.m
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Cadastre.h"
#import "CadastreAreaNodeByName.h"
#import "CadastreAreaNodeByNumber.h"
#import "CSVLoader.h"

@interface Cadastre ()

@property (strong, nonatomic) Treap *citizens;
@property (strong, nonatomic) Treap *areasByName;
@property (strong, nonatomic) Treap *areasByNumber;

@end

@implementation Cadastre;

#pragma mark - Singleton

+ (Cadastre *)sharedCadastre
{
    static dispatch_once_t once;
    static Cadastre *cadastre;
    
    dispatch_once(&once, ^{
        cadastre = [Cadastre new];
        cadastre.citizens = [Treap new];
        cadastre.areasByName = [Treap new];
        cadastre.areasByNumber = [Treap new];
    });
    return cadastre;
}

#pragma mark - Insertion

- (BOOL)addCitizen:(Citizen *)citizen
{
    return [self.citizens addObject:citizen];
}

- (BOOL)addCitizenWithBirthNumber:(NSString *)birthNumber
                             name:(NSString *)name
                          surname:(NSString *)surname
{
    Citizen *newCitizen = [[Citizen alloc] initWithBirthNumber:birthNumber name:name surname:surname];
    return [self.citizens addObject:newCitizen];
}

- (BOOL)addCadastreArea:(CadastreArea *)area
{
    BOOL success = [self.areasByName add:[CadastreAreaNodeByName nodeWithData:area]];
    if (success) {
        success = [self.areasByNumber add:[CadastreAreaNodeByNumber nodeWithData:area]];
        if (success) {
            return YES;
        } else {
            CadastreAreaNodeByName *nodeByName = (CadastreAreaNodeByName *)[self.areasByName find:[CadastreAreaNodeByName nodeWithData:area]];
            [self.areasByName remove:nodeByName];
        }
    }
    return NO;
}

- (BOOL)addCadastreAreaWithNumber:(NSInteger)number
                             name:(NSString *)name
{
    CadastreArea *newArea = [CadastreArea areaWithName:name number:[NSNumber numberWithInteger:number]];
    
    BOOL success = [self.areasByName add:[CadastreAreaNodeByName nodeWithData:newArea]];
    if (success) {
        success = [self.areasByNumber add:[CadastreAreaNodeByNumber nodeWithData:newArea]];
        if (success) {
            return YES;
        } else {
            CadastreAreaNodeByName *nodeByName = (CadastreAreaNodeByName *)[self.areasByName find:[CadastreAreaNodeByName nodeWithData:newArea]];
            [self.areasByName remove:nodeByName];
        }
    }
    return NO;
}

- (BOOL)addProperty:(NSNumber *)propertyNumber
     toPropertyList:(PropertyList *)list
     inCadastreArea:(CadastreArea *)area
{
    Property *property = [Property propertyWithNumber:propertyNumber inCadastreArea:area];
    BOOL success = [area addProperty:property];
    if (success) {
        [list addProperty:property];
        return YES;
    }
    return NO;
}

- (BOOL)setShareholdingToCitizen:(NSString *)birthNumber
                  toPropertyList:(PropertyList *)propertyList
{
    Citizen *citizen = [self citizenByBirthNumber:birthNumber];
    if (citizen) {
        return [propertyList addOwnerWithEqualShare:citizen];
    }
    return NO;
}

#pragma mark - Fetches

- (Citizen *)citizenByBirthNumber:(NSString *)birthNumber
{
    return (Citizen *)[self.citizens findObject:[Citizen citizenWithBirthNumber:birthNumber]];
}

- (CadastreArea *)areaByNumber:(NSNumber *)number
{
    CadastreArea *area = [CadastreArea areaWithNumber:number];
    return (CadastreArea *)[self.areasByNumber findObject:area];
}

- (CadastreArea *)areaByName:(NSString *)name
{
    CadastreArea *area = [CadastreArea areaWithName:name];
    return (CadastreArea *)[self.areasByName findObject:area];
}

- (Property *)propertyByNumber:(NSNumber *)number
                inCadastreArea:(CadastreArea *)area
{
    return [area propertyByNumber:number];
}

- (PropertyList *)propertyListByNumber:(NSNumber *)number
                        inCadastreArea:(CadastreArea *)area
{
    return [area propertyListByNumber:number];
}

- (NSArray *)propertiesOfOwner:(Citizen *)owner
                inCadastreArea:(CadastreArea *)area
{
    NSMutableArray *properties = [NSMutableArray new];
    
    for (PropertyList *list in owner.propertyLists) {
        if (list.area == area) {
            [properties addObjectsFromArray:list.properties];
        }
    }
    return properties;
}

- (NSArray *)citizensWithPermaAddress:(NSNumber *)propertyNumber
                       inCadastreArea:(CadastreArea *)area
{
    Property *property = [self propertyByNumber:propertyNumber inCadastreArea:area];
    return property.citizens;
}

- (NSArray *)propertiesOfOwner:(NSString *)birthNumber
{
    Citizen *owner = [self citizenByBirthNumber:birthNumber];
    
    return [owner allProperties];
}

- (NSArray *)propertiesInCadastreArea:(CadastreArea *)area
{
    return [area allProperties];
}

- (NSArray *)cadastreAreas
{
    return [self.areasByNumber inOrderTraversal];
}

#pragma mark - Updates

- (BOOL)changeOwner:(Citizen *)owner
         ofProperty:(Property *)property
         toNewOwner:(Citizen *)newOwner
{
    BOOL success = [property.propertyList removeOwner:owner];
    if (success) {
        return [property.propertyList addOwnerWithEqualShare:newOwner];
    }
    return NO;
}

- (BOOL)changePermanentAddressOfOwner:(Citizen *)owner
                           toProperty:(Property *)property
{
    owner.property = property;
    [property.citizens addObject:owner];
    return YES;
}

#pragma mark - Deletions

- (BOOL)removeCadastreArea:(CadastreArea *)area
           andMoveAgendaTo:(CadastreArea *)newArea
{
    [area moveAgendaToArea:newArea];
    CadastreAreaNodeByName *nodeByName = (CadastreAreaNodeByName *)[self.areasByName find:[CadastreAreaNodeByName nodeWithData:area]];
    CadastreAreaNodeByNumber *nodeByNumber = (CadastreAreaNodeByNumber *)[self.areasByNumber find:[CadastreAreaNodeByNumber nodeWithData:area]];

    if (nodeByName && nodeByNumber) {
        BOOL success = [self.areasByName remove:nodeByName];
        if (success) {
            return [self.areasByNumber remove:nodeByNumber];
        }
    }
    return NO;
}

- (BOOL)removeCitizenByBirthNumber:(NSString *)birthNumber
{
    Citizen *owner = [Citizen citizenWithBirthNumber:birthNumber];
    
    if (owner) {
        for (PropertyList *list in owner.propertyLists) {
            [list removeOwner:owner];
        }
        return [self.citizens removeObject:owner];
    }
    return NO;
}

- (BOOL)removeProperty:(Property *)property
      fromPropertyList:(PropertyList *)propertyList
        inCadastreArea:(CadastreArea *)cadastreArea
{
    BOOL success = [cadastreArea removeProperty:property];
        if (success) {
            [propertyList removeProperty:property];
            return YES;
        }
    return NO;
}

- (BOOL)removePropertyList:(PropertyList *)oldList
          fromCadastreArea:(CadastreArea *)area
                 toNewList:(PropertyList *)newList
{
    if ([oldList movePropertiesAndOwnersToNewList:newList]) {
        return [area removePropertyList:oldList];
    }
    return NO;
}

#pragma mark - CSV

- (void)exportToCSV
{
    [self removeCSVFiles];
    
    [self.citizens exportToCSV:kCitizensCSVFile];
    [self.areasByNumber exportToCSV:kAreasCSVFile];
    for (CadastreArea *area in [self cadastreAreas]) {
        [area.propertyLists exportToCSV:kListsCSVFile];
        [area.properties exportToCSV:kPropertiesCSVFile];
    }
}

- (void)removeCSVFiles
{
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:kHomeDirectory];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:kCitizensCSVFile];
    [fileMgr removeItemAtPath:path error:&error];
    
    path = [documentsDirectory stringByAppendingPathComponent:kPropertiesCSVFile];
    [fileMgr removeItemAtPath:path error:&error];
    
    path = [documentsDirectory stringByAppendingPathComponent:kAreasCSVFile];
    [fileMgr removeItemAtPath:path error:&error];
    
    path = [documentsDirectory stringByAppendingPathComponent:kShareholdingsCSVFile];
    [fileMgr removeItemAtPath:path error:&error];
    
    path = [documentsDirectory stringByAppendingPathComponent:kListsCSVFile];
    [fileMgr removeItemAtPath:path error:&error];
}

- (BOOL)importFromCSV
{
    if ([CSVLoader loadAreas]) {
        if ([CSVLoader loadCitizens]) {
            if ([CSVLoader loadLists]) {
                if ([CSVLoader loadProperties]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

#pragma mark - Misc

- (void)generateData
{
    for (NSInteger i = 0; i < areas; i++) {
        [[Cadastre sharedCadastre] addCadastreArea:[CadastreArea randomData]];
    }
}

@end
