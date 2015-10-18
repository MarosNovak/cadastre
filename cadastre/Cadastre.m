//
//  Cadastre.m
//  cadastre
//
//  Created by Maros Novák on 10/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "Cadastre.h"
#import "Citizen.h"

@interface Cadastre ()

@property (strong, nonatomic) Treap *citizens;
@property (strong, nonatomic) Treap *areas;

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
        cadastre.areas = [Treap new];
    });
    return cadastre;
}

#pragma mark - Insertion

- (void)addCitizenWithBirthNumber:(NSString *)birthNumber
                             name:(NSString *)name
                          surname:(NSString *)surname
{
    Citizen *newCitizen = [[Citizen alloc] initWithBirthNumber:birthNumber name:name surname:surname];
    [self.citizens addObject:newCitizen];
}

#pragma mark - Fetches

- (Citizen *)searchCitizensByBirthNumber:(NSString *)birthNumber
{
    return (Citizen *)[self.citizens findObject:[Citizen citizenWithBirthNumber:birthNumber]];
}

#pragma mark - Deletions

@end
