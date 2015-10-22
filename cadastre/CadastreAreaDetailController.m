//
//  CadastreAreaDetailControllerTableViewController.m
//  cadastre
//
//  Created by Maros Novák on 22/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CadastreAreaDetailController.h"
#import "Cadastre.h"

@interface CadastreAreaDetailController ()

@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNameField;

@end

@implementation CadastreAreaDetailController

- (void)viewDidLoad
{
    self.title = self.area.name;
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1 && self.cadastreAreaNameField.text != nil) {
        [self showAlertController];
    }
}

- (void)showAlertController
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Remove cadastre area"
                                                                        message:[NSString stringWithFormat:@"Area will be moved to other area:%@",self.cadastreAreaNameField.text]
                                                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self removeCadastreArea];
    }];
    
    [controller addAction:deleteAction];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)removeCadastreArea
{
    BOOL success = [Cadastre sharedCadastre];
    if (success) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
