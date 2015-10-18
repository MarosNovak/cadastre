//
//  Cadastre.m
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Cadastre.h"
#import "Citizen.h"
#import "CadastreArea.h"
#import "CadastreAreaNodeByName.h"
#import "CadastreAreaNodeByNumber.h"

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

- (BOOL)addCitizenWithBirthNumber:(NSString *)birthNumber
                             name:(NSString *)name
                          surname:(NSString *)surname
{
    Citizen *newCitizen = [[Citizen alloc] initWithBirthNumber:birthNumber name:name surname:surname];
    return [self.citizens addObject:newCitizen];
}

- (BOOL)addCadastreAreaWithNumber:(NSInteger)number
                             name:(NSString *)name
{
    CadastreArea *newArea = [CadastreArea areaWithName:name number:[NSNumber numberWithInteger:number]];
    
    BOOL added = [self.areasByName add:[CadastreAreaNodeByName nodeWithData:newArea]];
    if (added) {
        added = [self.areasByNumber add:[CadastreAreaNodeByNumber nodeWithData:newArea]];
        if (added) return YES;
        else [self.areasByName remove:[CadastreAreaNodeByName nodeWithData:newArea]];
    }
    return NO;
}

#pragma mark - Fetches

- (Citizen *)citizenByBirthNumber:(NSString *)birthNumber
{
    return (Citizen *)[self.citizens findObject:[Citizen citizenWithBirthNumber:birthNumber]];
}

- (NSArray *)cadastreAreas
{
    return [self.areasByName levelOrderTraversal];
}

#pragma mark - Deletions

- (BOOL)removeCitizenByBirthNumber:(NSString *)birthNumber
{
    return [self.citizens removeObject:[Citizen citizenWithBirthNumber:birthNumber]];
}

@end
