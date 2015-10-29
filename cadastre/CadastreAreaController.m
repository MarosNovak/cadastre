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
#import "UITableViewController+Alerts.h"

@interface CadastreAreaController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNameField;

@end

@implementation CadastreAreaController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UITextFieldDelegate

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
    
    if (number.length > 0 && name.length > 0) {
        if ([[Cadastre sharedCadastre] addCadastreAreaWithNumber:number.integerValue name:name]) {
            [self showSuccessAlertWithMessage:@"Cadastre Area added."];
        } else {
            [self showWarningAlertWithMessage:@"Cadastre Area already exists."];
        }
        [self clearFields];
    } else {
        [self showNotifyAlertFillAllFields];
    }
}

- (void)clearFields
{
    self.cadastreAreaNumberField.text = nil;
    self.cadastreAreaNameField.text = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SearchController *searchVC = segue.destinationViewController;

    if ([segue.identifier isEqualToString:@"showCadastreSearchByName"]) {
        searchVC.searchType = SearchTypeCadastreAreaByName;
    }
    if ([segue.identifier isEqualToString:@"showCadastreSearchByNumber"]) {
        searchVC.searchType = SearchTypeCadastreAreaByNumber;
    }
    if ([segue.identifier isEqualToString:@"showListOfCadastre"]) {
        searchVC.searchType = SearchTypeNone;
    }
}

@end
