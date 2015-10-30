//
//  PropertyDetailController.m
//  cadastre
//
//  Created by Maros Novák on 25/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertyDetailController.h"
#import "PropertyList.h"
#import "Shareholding.h"

@interface PropertyDetailController ()

@property (strong, nonatomic) PropertyList *list;

@end

@implementation PropertyDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.property.number.stringValue;
    self.list = self.property.propertyList;
   
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.shareholdings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PropertyDetailCell" forIndexPath:indexPath];
    
    Shareholding *shareholding = self.list.shareholdings[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Owner name: %@",shareholding.owner.fullName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Share: %ld%%", (long)shareholding.share.doubleValue];
    
    return cell;
}

@end
