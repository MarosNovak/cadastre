//
//  InsertionController.h
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    InsertionTypeCitizen,
    InsertionTypeProperty,
    InsertionTypeCadastreArea,
    InsertionTypePropertyList
} InsertionType;

@interface InsertionController : UITableViewController

@property (nonatomic) InsertionType type;

@end
