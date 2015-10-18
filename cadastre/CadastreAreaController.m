//
//  CadastreAreaController.m
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CadastreAreaController.h"
#import "SearchController.h"
#import "Cadastre.h"

@interface CadastreAreaController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNameField;

@end

@implementation CadastreAreaController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.cadastreAreaNameField) {
        [self.cadastreAreaNameField resignFirstResponder];
        [self addCadastreArea];
    }
    return NO;
}

- (void)addCadastreArea
{
    NSString *number = self.cadastreAreaNumberField.text;
    NSString *name = self.cadastreAreaNameField.text;
    
    [[Cadastre sharedCadastre] addCadastreAreaWithNumber:[number integerValue] name:name];
    
    [self clearFields];
}

- (void)clearFields
{
    self.cadastreAreaNumberField.text = nil;
    self.cadastreAreaNameField.text = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SearchController *searchVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"showList"]) {
        searchVC.searchType = SearchTypeNone;
    }
}

@end
