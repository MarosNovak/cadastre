//
//  PropertyController.m
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertyController.h"
#import "SearchController.h"
#import "Cadastre.h"
#import "UITableViewController+Alerts.h"

@interface PropertyController ()

@property (weak, nonatomic) IBOutlet UITextField *propertyNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNumberField;
@property (weak, nonatomic) IBOutlet UITextField *propertyListNumberField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;

@end

@implementation PropertyController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.propertyNumberField) {
        [self.propertyNumberField resignFirstResponder];
        [self addProperty];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"showSearchOfProperties" sender:nil];
    }
}

- (void)addProperty
{
    if (self.propertyNumberField.text.length && self.cadastreAreaNumberField.text.length && self.propertyListNumberField.text.length) {
        CadastreArea *area = [[Cadastre sharedCadastre] areaByNumber:@(self.cadastreAreaNumberField.text.integerValue)];
        if (area) {
            PropertyList *propertyList = [[Cadastre sharedCadastre] propertyListByNumber:@(self.propertyListNumberField.text.integerValue) inCadastreArea:area];
            if (propertyList) {
                if ([[Cadastre sharedCadastre] addProperty:@(self.propertyNumberField.text.integerValue)
                                               withAddress:self.addressField.text
                                            toPropertyList:propertyList
                                            inCadastreArea:area]) {
                    [self showSuccessAlertWithMessage:@"Property added successfully."];
                } else {
                    [self showWarningAlertWithMessage:@"Property already exists."];
                }
            } else {
                [self showWarningAlertWithMessage:@"Property list not found."];
            }
        } else {
            [self showWarningAlertWithMessage:@"Cadastre area not found."];
        }
        [self clearFields];
    } else {
        [self showNotifyAlertFillAllFields];
    }
}

- (void)clearFields
{
    self.cadastreAreaNumberField.text = nil;
    self.propertyListNumberField.text = nil;
    self.propertyNumberField.text = nil;
    self.addressField.text = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SearchController *searchVC = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"showSearchOfProperties"]) {
        searchVC.searchType = SearchTypePropertiesByBirthNumber;
    }
}

@end
