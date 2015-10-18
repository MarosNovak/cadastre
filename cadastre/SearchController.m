//
//  SearchController.m
//  cadastre
//
//  Created by Maros Novák on 18/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "SearchController.h"
#import "Cadastre.h"

@interface SearchController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) id result;

@end

@implementation SearchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.searchBar becomeFirstResponder];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:(CGRectZero)];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.result ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ([self.result isKindOfClass:[Citizen class]]) {
        Citizen *citizen = (Citizen *)self.result;
        cell.textLabel.text = [citizen fullName];
        cell.detailTextLabel.text = citizen.birthNumber;
    }
    
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.result = [[Cadastre sharedCadastre] citizenByBirthNumber:searchText];
    [self.tableView reloadData];
}

@end
