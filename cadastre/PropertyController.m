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

@interface PropertyController ()

@property (weak, nonatomic) IBOutlet UITextField *propertyNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cadastreAreaNumberField;
@property (weak, nonatomic) IBOutlet UITextField *propertyListNumberField;

@end

@implementation PropertyController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.propertyListNumberField) {
        [self.propertyListNumberField resignFirstResponder];
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
    NSString *propertyNumber = self.propertyNumberField.text;
    NSString *cadastreAreaNumber = self.cadastreAreaNumberField.text;
    NSString *propertyListNumber = self.propertyListNumberField.text;
    
    [[Cadastre sharedCadastre] addProperty:@(propertyNumber.integerValue)
                            toPropertyList:@(propertyListNumber.integerValue)
                            inCadastreArea:@(cadastreAreaNumber.integerValue)];
    
    [self clearFields];
}

- (void)clearFields
{
    self.cadastreAreaNumberField.text = nil;
    self.propertyListNumberField.text = nil;
    self.propertyNumberField.text = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SearchController *searchVC = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"showSearchOfProperties"]) {
        searchVC.searchType = SearchTypePropertiesByBirthNumber;
    }
}

@end
