//
//  SearchController.m
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "SearchController.h"
#import "Cadastre.h"
#import "CadastreArea.h"
#import "CitizenDetailController.h"
#import "CadastreAreaDetailController.h"

@interface SearchController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) id result;

@end

@implementation SearchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.searchBar becomeFirstResponder];
    [self setupView];
}

- (void)setupView
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:(CGRectZero)];

    switch (self.searchType) {
        case SearchTypeCadastreAreaByName:
            self.searchBar.placeholder = @"cadastre area name";
            break;
        case SearchTypeCadastreAreaByNumber:
            self.searchBar.placeholder = @"cadastre area number";
            break;
        case SearchTypeNone:
            self.searchBar.hidden = YES;
            [self.searchBar resignFirstResponder];
            self.result = [[Cadastre sharedCadastre] cadastreAreas];
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.result isKindOfClass:[NSArray class]]) {
        return ((NSArray *)self.result).count;
    } else {
        return self.result ? 1 : 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    switch (self.searchType) {
        case SearchTypeCitizensByBirthNumber: {
            if ([self.result isKindOfClass:[Citizen class]]) {
                Citizen *citizen = (Citizen *)self.result;
               
                cell.textLabel.text = [citizen fullName];
                cell.detailTextLabel.text = citizen.birthNumber;
                
                return cell;
            }
        }
        case SearchTypeCadastreAreaByName:
        case SearchTypeCadastreAreaByNumber: {
            if ([self.result isKindOfClass:[CadastreArea class]]) {
                CadastreArea *area = (CadastreArea *)self.result;
                
                cell.textLabel.text = area.name;
                cell.detailTextLabel.text = area.number.stringValue;
                
                return cell;
            }
        }
            
        case SearchTypeNone: {
            if ([self.result isKindOfClass:[NSArray class]]) {
                CadastreArea *area = ((NSArray *)self.result)[indexPath.row];
               
                cell.textLabel.text = area.name;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",area.number.integerValue];
               
                return cell;
            }
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.searchType) {
        case SearchTypeCitizensByBirthNumber: {
            Citizen *citizen = (Citizen *)self.result;
            [self performSegueWithIdentifier:@"showCitizen" sender:citizen];
        }
            break;
        case SearchTypeCadastreAreaByName:
        case SearchTypeCadastreAreaByNumber: {
            CadastreArea *area = (CadastreArea *)self.result;
            [self performSegueWithIdentifier:@"showArea" sender:area];
        }
            break;
        default: {
            CadastreArea *area = (CadastreArea *)self.result[indexPath.row];
            [self performSegueWithIdentifier:@"showArea" sender:area];
        }
            break;
    }
}

#pragma mark - Search Bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.result = nil;
    switch (self.searchType) {
        case SearchTypeCitizensByBirthNumber:
            self.result = [[Cadastre sharedCadastre] citizenByBirthNumber:searchText];
            break;
        case SearchTypeCadastreAreaByNumber: {
            if (searchText.length > 0) {
                self.result = [[Cadastre sharedCadastre] areaByNumber:@(searchText.integerValue)];
            }
        }
            break;
        default:
            case SearchTypeCadastreAreaByName:
            self.result = [[Cadastre sharedCadastre] areaByName:searchText];
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showCitizen"]) {
        CitizenDetailController *citizenVC = segue.destinationViewController;
        
        citizenVC.citizen = sender;
    }
    if ([segue.identifier isEqualToString:@"showArea"]) {
        CadastreAreaDetailController *areaVC = segue.destinationViewController;
        
        areaVC.area = sender;
    }
}

@end
