//
//  CitizenDetailController.m
//  cadastre
//
//  Created by Maros Novák on 19/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CitizenDetailController.h"
#import "Cadastre.h"
#import "UITableViewController+Alerts.h"

@interface CitizenDetailController ()

@property (weak, nonatomic) IBOutlet UITextField *propertyNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNameField;
@property (weak, nonatomic) IBOutlet UILabel *permanentAddressField;

@end

@implementation CitizenDetailController

- (void)viewDidLoad
{
    self.title = [NSString stringWithFormat:@"%@ (%@)", self.citizen.fullName, self.citizen.birthNumber];
    [self setupPermanentAddress];
    
    [super viewDidLoad];
}

- (void)setupPermanentAddress
{
    self.permanentAddressField.text = self.citizen.property.address ? self.citizen.property.address : @"Citizen is homeless.";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        [self showAlertController];
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        [self updatePermanentAddress];
        [self.propertyNumberField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.cadastreAreaNameField) {
        [self.propertyNumberField becomeFirstResponder];
    }
    if (textField == self.propertyNumberField) {
        [self.propertyNumberField resignFirstResponder];
    }
    return NO;
}

- (void)showAlertController
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Remove citizen"
                                                                        message:@"Rly?"
                                                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *action) {
        [self removeCitizen];
    }];
    
    [controller addAction:deleteAction];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)updatePermanentAddress
{
    if (self.propertyNumberField.text.length && self.cadastreAreaNameField.text.length) {
        CadastreArea *area = [[Cadastre sharedCadastre] areaByName:self.cadastreAreaNameField.text];
        if (area) {
            Property *property = [[Cadastre sharedCadastre] propertyByNumber:@(self.propertyNumberField.text.integerValue) inCadastreArea:area];
            if (property) {
                [[Cadastre sharedCadastre] changePermanentAddressOfOwner:self.citizen
                                                              toProperty:property];
                [self showSuccessAlertWithMessage:@"Permanent address changed successfully."];
                [self setupPermanentAddress];
            } else {
                [self showWarningAlertWithMessage:@"Property not found."];
            }
        } else {
            [self showWarningAlertWithMessage:@"Cadastre area not found."];
        }
        [self clearFields];
    } else {
        [self showNotifyAlertFillAllFields];
    }
}

- (void)removeCitizen
{
    BOOL success = [[Cadastre sharedCadastre] removeCitizenByBirthNumber:self.citizen.birthNumber];
    if (success) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)clearFields
{
    self.cadastreAreaNameField.text = nil;
    self.propertyNumberField.text = nil;
}

@end
