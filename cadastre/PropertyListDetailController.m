//
//  PropertyListDetailController.m
//  cadastre
//
//  Created by Maros Novák on 27/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertyListDetailController.h"
#import "UITableViewController+Alerts.h"
#import "PropertyDetailController.h"
#import "PropertiesController.h"
#import "InfoController.h"
#import "Cadastre.h"

@interface PropertyListDetailController ()

@property (weak, nonatomic) IBOutlet UITextField *birthNumberField;
@property (weak, nonatomic) IBOutlet UITextField *propertyListNumber;
@property (weak, nonatomic) IBOutlet UITextField *propertyNumberField;

@end

@implementation PropertyListDetailController

- (void)viewDidLoad
{
    self.title = self.list.number.stringValue;
    
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"showList" sender:self.list.shareholdings];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self performSegueWithIdentifier:@"showProperties" sender:self.list.properties];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        [self setShareholding];
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        [self removeShareholding];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        [self showAlertController];
    }
    self.birthNumberField.text = nil;
}

- (void)removeShareholding
{
    if (self.birthNumberField.text.length) {
        Citizen *owner = [[Cadastre sharedCadastre] citizenByBirthNumber:self.birthNumberField.text];
        if (owner) {
            if ([self.list removeOwner:owner]) {
                [self showSuccessAlertWithMessage:@"Citizen removed from property list."];
            } else {
                [self showWarningAlertWithMessage:@"Citizen can't be removed."];
            }
        } else {
            [self showWarningAlertWithMessage:@"Citizen not found."];
        }
    } else {
        [self showNotifyAlertFillAllFields];
    }
    [self.birthNumberField resignFirstResponder];
}

- (void)setShareholding
{
    if (self.birthNumberField.text.length) {
        Citizen *owner = [[Cadastre sharedCadastre] citizenByBirthNumber:self.birthNumberField.text];
        if (owner) {
            if ([self.list addOwnerWithEqualShare:owner]) {
                [self showSuccessAlertWithMessage:@"Citizen added to property list."];
            } else {
                [self showWarningAlertWithMessage:@"Citizen can't be added."];
            }
        } else {
            [self showWarningAlertWithMessage:@"Citizen not found."];
        }
    } else {
        [self showNotifyAlertFillAllFields];
    }
    [self.birthNumberField resignFirstResponder];
}

- (void)removePropertyList
{
    if (self.propertyListNumber.text.length) {
        PropertyList *newList = [[Cadastre sharedCadastre] propertyListByNumber:@(self.propertyListNumber.text.integerValue) inCadastreArea:self.list.area];
        if (newList && newList != self.list) {
            if ([[Cadastre sharedCadastre] removePropertyList:self.list
                                             fromCadastreArea:self.list.area
                                                    toNewList:newList]) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [self showWarningAlertWithMessage:@"Property list can't be removed."];
            }
        } else {
            [self showWarningAlertWithMessage:@"Property list not found."];
        }
    } else {
        [self showNotifyAlertFillAllFields];
    }
}

- (void)showAlertController
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Remove property list"
                                                                        message:[NSString stringWithFormat:@"Property list will be moved to:%@",self.propertyListNumber.text]
                                                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                             [controller dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *action) {
                                                             [self removePropertyList];
                                                         }];
    
    [controller addAction:deleteAction];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showList"]) {
        InfoController *infoVC = segue.destinationViewController;
        infoVC.list = sender;
    }
    if ([segue.identifier isEqualToString:@"showProperties"]) {
        PropertiesController *propertiesVC = segue.destinationViewController;
        propertiesVC.properties = sender;
    }
}

@end
