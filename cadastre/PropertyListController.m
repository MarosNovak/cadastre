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
    NSString *areaNumber = self.cadastreAreaNumberField.text;
    NSString *propertyListNumber = self.propertyListNumberField.text;
    
    CadastreArea *area = [[Cadastre sharedCadastre] areaByNumber:[NSNumber numberWithInteger:areaNumber.integerValue]];
    if (area) {
        BOOL success = [area addPropertyListWithNumber:[NSNumber numberWithInteger:propertyListNumber.integerValue]];
        if (success) {
            NSLog(@"Pridal sa list do area");
        } else {
            NSLog(@"nepridal sa list do area");
        }
    } else {
        NSLog(@"nenasla sa area");
    }
    
    [self clearFields];
}

- (void)clearFields
{
    self.cadastreAreaNumberField.text = nil;
    self.propertyListNumberField.text = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SearchController *searchVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"showList"]) {
        searchVC.searchType = SearchTypeNone;
    }
}

@end
