//
//  PropertyDetailController.m
//  cadastre
//
//  Created by Maros Novák on 25/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertyDetailController.h"

@interface PropertyDetailController ()

@end

@implementation PropertyDetailController

- (void)viewDidLoad
{
    self.title = self.property.number.stringValue;
    
    [super viewDidLoad];
}

@end
