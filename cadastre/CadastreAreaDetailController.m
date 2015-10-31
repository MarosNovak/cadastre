//
//  CadastreAreaDetailControllerTableViewController.m
//  cadastre
//
//  Created by Maros Novák on 22/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CadastreAreaDetailController.h"
#import "PropertyDetailController.h"
#import "PropertiesController.h"
#import "PropertyListDetailController.h"
#import "Cadastre.h"
#import "UITableViewController+Alerts.h"

@interface CadastreAreaDetailController ()

@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNameField;
@property (weak, nonatomic) IBOutlet UITextField *propertyNumberField;
@property (weak, nonatomic) IBOutlet UITextField *propertyListNumberField;
@property (weak, nonatomic) IBOutlet UITextField *birthNumberField;

@end

@implementation CadastreAreaDetailController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    self.title = self.area.name;
    
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self showLisOfProperties];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        [self showPropertyDetail];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        [self showPropertiesOfOwner];
    }
    if (indexPath.section == 3 && indexPath.row == 1) {
        [self showPropertyListDetail];
    }
    if (indexPath.section == 4 && indexPath.row == 1 && self.cadastreAreaNameField.text != nil) {
        [self showAlertController];
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showListOfProperties"]) {
        PropertiesController *propertiesVC = segue.destinationViewController;
        propertiesVC.properties = sender;
    }
    if ([segue.identifier isEqualToString:@"showPropertyDetail"]) {
        PropertyDetailController *propertyDetailVC = segue.destinationViewController;
        propertyDetailVC.list = sender;
    }
    if ([segue.identifier isEqualToString:@"showPropertyListDetail"]) {
        PropertyListDetailController *propertyListVC = segue.destinationViewController;
        propertyListVC.list = sender;
    }
}

- (void)showAlertController
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Remove cadastre area"
                                                                        message:[NSString stringWithFormat:@"Area will be moved to other area:%@",self.cadastreAreaNameField.text]
                                                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *action) {
        [self removeCadastreArea];
    }];
    
    [controller addAction:deleteAction];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)showLisOfProperties
{
    NSArray *properties = [[Cadastre sharedCadastre] propertiesInCadastreArea:self.area];
    if (properties.count) {
        [self performSegueWithIdentifier:@"showListOfProperties" sender:properties];
    } else {
        [self showWarningAlertWithMessage:@"Properties not found."];
    }
}

- (void)showPropertyDetail
{
    if (self.propertyNumberField.text.length) {
        Property *property = [[Cadastre sharedCadastre] propertyByNumber:@(self.propertyNumberField.text.integerValue) inCadastreArea:self.area];
        if (property) {
            [self performSegueWithIdentifier:@"showPropertyDetail" sender:property.propertyList.shareholdings];
        } else {
            [self showWarningAlertWithMessage:@"Property not found."];
        }
        self.self.propertyNumberField.text = nil;
    } else {
        [self showNotifyAlertFillAllFields];
    }
}

- (void)showPropertyListDetail
{
    if (self.propertyListNumberField.text.length) {
        PropertyList *list = [[Cadastre sharedCadastre] propertyListByNumber:@(self.propertyListNumberField.text.integerValue) inCadastreArea:self.area];
        if (list) {
            [self performSegueWithIdentifier:@"showPropertyListDetail" sender:list];
        } else {
            [self showWarningAlertWithMessage:@"Property list not found."];
        }
        self.propertyListNumberField.text = nil;
    } else {
        [self showNotifyAlertFillAllFields];
    }
}

- (void)showPropertiesOfOwner
{
    if (self.birthNumberField.text.length) {
        NSArray *properties = [[Cadastre sharedCadastre] propertiesOfOwner:self.birthNumberField.text inCadastreArea:self.area];
        if (properties.count) {
            [self performSegueWithIdentifier:@"showListOfProperties" sender:properties];
        } else {
            [self showWarningAlertWithMessage:@"Properties not found."];
        }
        self.birthNumberField.text = nil;
    } else {
        [self showNotifyAlertFillAllFields];
    }
}

- (void)removeCadastreArea
{
    if (self.cadastreAreaNameField.text.length) {
        if ([[Cadastre sharedCadastre] removeCadastreArea:self.area andMoveAgendaTo:@(self.cadastreAreaNameField.text.integerValue)]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [self showWarningAlertWithMessage:@"Something went wrong."];
        }
    } else {
        [self showNotifyAlertFillAllFields];
    }
}

@end
