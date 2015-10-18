//
//  CadastreAreaController.m
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CadastreAreaController.h"
#import "InsertionController.h"

@interface CadastreAreaController ()

@end

@implementation CadastreAreaController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    InsertionController *insertionVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"addCadastreArea"]) {
        insertionVC.type = InsertionTypeCadastreArea;
    }
}

@end
