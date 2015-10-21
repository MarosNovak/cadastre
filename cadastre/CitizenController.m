//
//  CitizenController.m
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CitizenController.h"
#import "Cadastre.h"

@interface CitizenController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *birthNumberField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *surnameField;

@end

@implementation CitizenController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

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
    
    [[Cadastre sharedCadastre] addCitizenWithBirthNumber:birthNumber name:name surname:surname];
   
    [self clearFields];
}

- (void)clearFields
{
    self.birthNumberField.text = nil;
    self.nameField.text = nil;
    self.surnameField.text = nil;
}

#warning pridat feedback do ui
- (IBAction)save:(id)sender
{
    [[Cadastre sharedCadastre] exportToCSV];
}

- (IBAction)load:(id)sender
{
    [[Cadastre sharedCadastre] importFromCSV];
}

@end
