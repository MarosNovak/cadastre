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

@interface Cadastre : NSObject

+ (Cadastre *)sharedCadastre;

- (void)addCitizenWithBirthNumber:(NSString *)birthNumber
                             name:(NSString *)name
                          surname:(NSString *)surname;

- (Citizen *)searchCitizensByBirthNumber:(NSString *)birthNumber;

@end
