//
//  PropertyListDetailController.m
//  cadastre
//
//  Created by Maros Novák on 27/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertyListDetailController.h"
#import "UITableViewController+Alerts.h"
#import "Cadastre.h"

@interface PropertyListDetailController ()

@property (weak, nonatomic) IBOutlet UITextField *birthNumberField;

@end

@implementation PropertyListDetailController

- (void)viewDidLoad
{
    self.title = self.list.number.stringValue;
    
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1) {
        
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        [self setShareholding];
    }
}

- (void)setShareholding
{
    if ([[Cadastre sharedCadastre] setShareholdingToCitizen:self.birthNumberField.text toPropertyList:self.list]) {
        [self showSuccessAlertWithMessage:@"Citizen added to property list."];
    } else {
        [self showWarningAlertWithMessage:@"Something went wrong"];
    }
    [self.birthNumberField resignFirstResponder];
}

@end
