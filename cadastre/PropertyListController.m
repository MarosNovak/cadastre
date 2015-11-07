//
//  PropertyListController.m
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertyListController.h"
#import "SearchController.h"
#import "Cadastre.h"
#import "PropertyList.h"
#import "CadastreArea.h"
#import "UITableViewController+Alerts.h"

@interface PropertyListController ()

@property (weak, nonatomic) IBOutlet UITextField *propertyListNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNumberField;

@end

@implementation PropertyListController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.propertyListNumberField) {
        [self.propertyListNumberField resignFirstResponder];
        [self addPropertyList];
    }
    return NO;
}

- (void)addPropertyList
{
    CadastreArea *area = [[Cadastre sharedCadastre] areaByNumber:@(self.cadastreAreaNumberField.text.integerValue)];
    if (area) {
        BOOL success = [area addPropertyListWithNumber:@(self.propertyListNumberField.text.integerValue)];
        if (success) {
            [self showSuccessAlertWithMessage:@"Property list added to cadastre area."];
        } else {
            [self showWarningAlertWithMessage:@"Property list already exists."];
        }
    } else {
        [self showWarningAlertWithMessage:@"Cadastre area not found."];
    }
    [self clearFields];
}

- (void)clearFields
{
    self.cadastreAreaNumberField.text = nil;
    self.propertyListNumberField.text = nil;
}

@end
