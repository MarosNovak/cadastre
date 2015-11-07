//
//  CitizenController.m
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CitizenController.h"
#import "Cadastre.h"
#import "UITableViewController+Alerts.h"

@interface CitizenController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *birthNumberField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *surnameField;

@end

@implementation CitizenController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.birthNumberField) {
        [self.surnameField becomeFirstResponder];
    }
    if (textField == self.nameField) {
        [self.surnameField becomeFirstResponder];
    }
    if (textField == self.surnameField) {
        [self.surnameField resignFirstResponder];
        [self addCitizen];
    }
    return NO;
}

- (void)addCitizen
{
    NSString *birthNumber = self.birthNumberField.text;
    NSString *name = self.nameField.text;
    NSString *surname = self.surnameField.text;
    
    if (birthNumber.length > 0 && name.length > 0 && surname.length > 0) {
        if ([[Cadastre sharedCadastre] addCitizenWithBirthNumber:birthNumber name:name surname:surname]) {
            [self showSuccessAlertWithMessage:@"Citizen added"];
        } else {
            [self showWarningAlertWithMessage:@"Citizen already exists"];
        }
        [self clearFields];
    } else {
        [self showNotifyAlertWithMessage:@"Fill all fields"];
    }
}

- (void)clearFields
{
    self.birthNumberField.text = nil;
    self.nameField.text = nil;
    self.surnameField.text = nil;
}

- (IBAction)save:(id)sender
{
    [[Cadastre sharedCadastre] exportToCSV];
}

- (IBAction)load:(id)sender
{
    if ([[Cadastre sharedCadastre] importFromCSV]) {
        [self showSuccessAlertWithMessage:@"Data imported."];
    } else {
        [self showWarningAlertWithMessage:@"Data failed to import."];
    }
}

@end
