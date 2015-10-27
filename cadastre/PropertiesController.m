//
//  PropertiesController.m
//  cadastre
//
//  Created by Maros Novák on 27/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertiesController.h"
#import "Property.h"

@interface PropertiesController ()

@end

@implementation PropertiesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.properties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PorpertyCell" forIndexPath:indexPath];
     
    Property *property = self.properties[indexPath.row];
     
    cell.textLabel.text = property.number.stringValue;
    cell.detailTextLabel.text = property.address;
    
    return cell;
}

@end
