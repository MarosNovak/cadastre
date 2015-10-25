//
//  CitizenDetailController.m
//  cadastre
//
//  Created by Maros Novák on 19/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CitizenDetailController.h"
#import "Cadastre.h"

@interface CitizenDetailController ()

@property (weak, nonatomic) IBOutlet UITextField *propertyNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNameField;

@end

@implementation CitizenDetailController

- (void)viewDidLoad
{
    self.title = self.citizen.fullName;
    
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self showAlertController];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
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
    NSString *cadastreAreaNumber = self.cadastreAreaNameField.text;
    NSString *propertyListNumber = self.propertyNumberField.text;

    [[Cadastre sharedCadastre] changePermanentAddressOfOwner:self.citizen
                                                  toProperty:@(propertyListNumber.integerValue)
                                              inCadastreArea:@(cadastreAreaNumber.integerValue)];
    [self clearFields];
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
