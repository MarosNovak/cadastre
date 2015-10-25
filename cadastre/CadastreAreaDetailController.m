//
//  CadastreAreaDetailControllerTableViewController.m
//  cadastre
//
//  Created by Maros Novák on 22/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CadastreAreaDetailController.h"
#import "PropertyDetailController.h"
#import "Cadastre.h"

@interface CadastreAreaDetailController ()

@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNameField;
@property (weak, nonatomic) IBOutlet UITextField *propertyNumberField;
@property (weak, nonatomic) IBOutlet UITextField *propertyListNumberField;

@end

@implementation CadastreAreaDetailController

- (void)viewDidLoad
{
    self.title = self.area.name;
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1 && self.cadastreAreaNameField.text != nil) {
        [self showAlertController];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        Property *property = [[Cadastre sharedCadastre] propertyByNumber:@(self.propertyNumberField.text.integerValue) inCadastreArea:self.area];
        [self performSegueWithIdentifier:@"showPropertyDetail" sender:property];
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

- (void)showPropertyDetail
{
    
}

- (void)showPropertyListDetail
{
    if ([[Cadastre sharedCadastre] removeCadastreArea:self.area andMoveAgendaTo:@(self.cadastreAreaNameField.text.integerValue)]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)removeCadastreArea
{
    if ([[Cadastre sharedCadastre] removeCadastreArea:self.area andMoveAgendaTo:@(self.cadastreAreaNameField.text.integerValue)]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showPropertyDetail"]) {
        PropertyDetailController *propertyDetailVC = segue.destinationViewController;
        propertyDetailVC.property = sender;
    }
}

@end
