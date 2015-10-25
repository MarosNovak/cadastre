//
//  SearchController.h
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SearchTypeCitizensByBirthNumber,
    SearchTypeCadastreAreaByName,
    SearchTypeCadastreAreaByNumber,
    SearchTypeNone,
} SearchType;

@interface SearchController : UITableViewController

@property (nonatomic) SearchType searchType;

@end
