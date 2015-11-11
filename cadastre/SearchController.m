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
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface SearchController () <UISearchBarDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) id result;

@end

@implementation SearchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self.searchBar becomeFirstResponder];
    [self setupView];
}

- (void)setupView
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:(CGRectZero)];

    switch (self.searchType) {
        case SearchTypePropertiesByBirthNumber:
            self.searchBar.placeholder = @"birth number";
            break;
        case SearchTypeCadastreAreaByName:
            self.searchBar.placeholder = @"cadastre area name";
            break;
        case SearchTypeCadastreAreaByNumber:
            self.searchBar.placeholder = @"cadastre area number";
            break;
        case SearchTypeNone:
            [self.searchBar removeFromSuperview];
            self.result = [[Cadastre sharedCadastre] cadastreAreasByName];
        default:
            break;
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
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
        case SearchTypePropertiesByBirthNumber: {
            if ([self.result isKindOfClass:[NSArray class]]) {
                Property *property = ((NSArray *)self.result)[indexPath.row];
                
                cell.textLabel.text = property.number.stringValue;
                cell.detailTextLabel.text = property.address;
                
                return cell;
            }
        }
            break;
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
        case SearchTypeNone: {
            CadastreArea *area = (CadastreArea *)self.result[indexPath.row];
            [self performSegueWithIdentifier:@"showArea" sender:area];
        }
            break;
        default:
        break;
    }
}

#pragma mark - Search Bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.result = nil;
    if (searchText.length > 0) {
        switch (self.searchType) {
            case SearchTypePropertiesByBirthNumber:
                self.result = [[Cadastre sharedCadastre] propertiesOfOwner:searchText];
            break;
            case SearchTypeCitizensByBirthNumber:
                self.result = [[Cadastre sharedCadastre] citizenByBirthNumber:searchText];
            break;
            case SearchTypeCadastreAreaByNumber:
                self.result = [[Cadastre sharedCadastre] areaByNumber:@(searchText.integerValue)];
            break;
            case SearchTypeCadastreAreaByName:
                self.result = [[Cadastre sharedCadastre] areaByName:searchText];
            break;
            default:
            break;
        }
    }
    [self.tableView reloadData];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Empty state

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"search"];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Not Found.\nFill search bar above and see results.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    if (self.result) {
        return NO;
    }
    return YES;
}

@end
