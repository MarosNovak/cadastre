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
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"showList" sender:self.list.shareholdings];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        [self showOwnersWithPermaAddress];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        [self setShareholding];
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        [self removeShareholding];
    }
    if (indexPath.section == 3 && indexPath.row == 1) {
        [self showAlertController];
    }
    self.birthNumberField.text = nil;
}

- (void)showOwnersWithPermaAddress
{
    if (self.propertyNumberField.text.length) {
        NSArray *citizens = [NSArray new];
        if ((citizens = [[Cadastre sharedCadastre] citizensWithPermaAddress:@(self.propertyNumberField.text.integerValue)
                                                             inCadastreArea:self.list.area])) {
            if (citizens.count) {
                [self performSegueWithIdentifier:@"showList" sender:citizens];
            } else {
                [self showWarningAlertWithMessage:@"Citizens not found."];
            }
        } else {
            [self showWarningAlertWithMessage:@"Something went wrong"];
        }
    } else {
        [self showNotifyAlertFillAllFields];
    }
    
    [self.propertyNumberField resignFirstResponder];
}

- (void)removeShareholding
{
    if (self.birthNumberField.text.length) {
        if ([[Cadastre sharedCadastre] removeShareholdingFromOwner:self.birthNumberField.text
                                                  fromPropertyList:self.list]) {
            [self showSuccessAlertWithMessage:@"Citizen removed from property list."];
        } else {
            [self showWarningAlertWithMessage:@"Something went wrong"];
        }
    } else {
        [self showNotifyAlertFillAllFields];
    }

    [self.birthNumberField resignFirstResponder];
}

- (void)setShareholding
{
    if (self.birthNumberField.text.length) {
        if ([[Cadastre sharedCadastre] setShareholdingToCitizen:self.birthNumberField.text
                                                 toPropertyList:self.list]) {
            [self showSuccessAlertWithMessage:@"Citizen added to property list."];
        } else {
            [self showWarningAlertWithMessage:@"Something went wrong"];
        }
    } else {
        [self showNotifyAlertFillAllFields];
    }
    [self.birthNumberField resignFirstResponder];
}

- (void)removePropertyList
{
    if (self.propertyListNumber.text.length) {
        if ([[Cadastre sharedCadastre] removePropertyList:self.list
                                         fromCadastreArea:self.list.area
                                                toNewList:@(self.propertyListNumber.text.integerValue)]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self showWarningAlertWithMessage:@"Something went wrong"];
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
}

@end
