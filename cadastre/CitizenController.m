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
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *spinerButton = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    UIBarButtonItem *current = self.navigationItem.rightBarButtonItem;
    
    self.navigationItem.rightBarButtonItem = spinerButton;
    [spinner startAnimating];
    [[Cadastre sharedCadastre] resetData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([[Cadastre sharedCadastre] importFromCSV]) {
             dispatch_async(dispatch_get_main_queue(), ^{
            [self showSuccessAlertWithMessage:@"Data imported."];
             });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
            [self showWarningAlertWithMessage:@"Data failed to import."];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            self.navigationItem.rightBarButtonItem = current;
        });
    });
}

@end
