//
//  PropertyDetailController.m
//  cadastre
//
//  Created by Maros Novák on 25/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertyDetailController.h"
#import "PropertyList.h"
#import "Shareholding.h"
#import "InfoController.h"
#import "UITableViewController+Alerts.h"
#import <UIScrollView+EmptyDataSet.h>
#import "Cadastre.h"

@interface PropertyDetailController () <DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (weak, nonatomic) IBOutlet UITextField *oldBirthNumberField;
@property (weak, nonatomic) IBOutlet UITextField *birthNumberField;

@end

@implementation PropertyDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = [NSString stringWithFormat:@"%@ (address: %@)",self.property.number, self.property.address];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
   
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"showList" sender:self.property.propertyList.shareholdings];
    }
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"showList" sender:self.property.citizens];
    }
    if (indexPath.section == 2) {
        [self changeOwner];
    }
    if (indexPath.section == 3) {
        [self showAlertController];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showList"]) {
        InfoController *infoVC = segue.destinationViewController;
        infoVC.list = sender;
    }
}

- (void)changeOwner
{
    if (self.oldBirthNumberField.text.length || self.birthNumberField.text.length) {
        Citizen *oldOwner = [[Cadastre sharedCadastre] citizenByBirthNumber:self.oldBirthNumberField.text];
        if (oldOwner) {
            if ([self.property.propertyList isCitizenOnPropertyList:oldOwner]) {
                Citizen *newOwner =  [[Cadastre sharedCadastre] citizenByBirthNumber:self.birthNumberField.text];
                if (newOwner) {
                    if ([[Cadastre sharedCadastre] changeOwner:oldOwner ofProperty:self.property toNewOwner:newOwner]) {
                        [self showSuccessAlertWithMessage:@"Owner changed."];
                        self.oldBirthNumberField.text = nil;
                        self.birthNumberField.text = nil;
                    } else {
                        [self showWarningAlertWithMessage:@"Owner can't be changed"];
                    }
                } else {
                    [self showWarningAlertWithMessage:@"New citizen not found."];
                    self.birthNumberField.text = nil;
                }
            } else {
                [self showWarningAlertWithMessage:@"Citizen is not owner of property."];
            }
        } else {
            [self showWarningAlertWithMessage:@"Old citizen not found."];
            self.oldBirthNumberField.text = nil;
        }
    } else {
        [self showNotifyAlertFillAllFields];
    }
}

- (void)showAlertController
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Remove property"
                                                                        message:[NSString stringWithFormat:@"Property will be removed permanently"]
                                                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                             [controller dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *action) {
                                                             [self removeProperty];
                                                         }];
    
    [controller addAction:deleteAction];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)removeProperty
{
    if ([[Cadastre sharedCadastre] removeProperty:self.property fromPropertyList:self.property.propertyList inCadastreArea:self.property.area]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
