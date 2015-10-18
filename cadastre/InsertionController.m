//
//  InsertionController.m
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "InsertionController.h"
#import "Cadastre.h"

@interface InsertionController ()

@property (weak, nonatomic) IBOutlet UITextField *citizenBirthNumberField;
@property (weak, nonatomic) IBOutlet UITextField *citizenNameField;
@property (weak, nonatomic) IBOutlet UITextField *citizenSurnameField;

@end

@implementation InsertionController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.type == InsertionTypeCitizen && section == 0) {
        return 3;
    } else if (self.type == InsertionTypeCadastreArea && section == 1) {
        return 2;
    }
    return 0;
}

- (IBAction)add:(id)sender
{
    switch (self.type) {
        case InsertionTypeCitizen: {
            NSString *birthNumber = self.citizenBirthNumberField.text;
            NSString *name = self.citizenNameField.text;
            NSString *surname = self.citizenSurnameField.text;
            [[Cadastre sharedCadastre] addCitizenWithBirthNumber:birthNumber name:name surname:surname];
            [self clearCitizenFields];
        }
            break;
            
        default:
            break;
    }
}

- (void)clearCitizenFields
{
    self.citizenSurnameField.text = nil;
    self.citizenNameField.text = nil;
    self.citizenBirthNumberField.text = nil;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.type = InsertionTypeCitizen) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//        
//        return cell;
//    }
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//    
//    return cell;
//}

@end
