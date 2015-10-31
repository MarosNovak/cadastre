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
#import <UIScrollView+EmptyDataSet.h>

@interface PropertyDetailController () <DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@end

@implementation PropertyDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
   
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PropertyDetailCell" forIndexPath:indexPath];
    
    if ([self.list[0] isKindOfClass:[Shareholding class]]) {
        Shareholding *shareholding = (Shareholding *)self.list[indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"Owner name: %@",shareholding.owner.fullName];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Share: %ld%%", (long)shareholding.share.doubleValue];
        
        return cell;
    } else if ([self.list[0] isKindOfClass:[Citizen class]]) {
        Citizen *citizen = (Citizen *)self.list[indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"Owner name: %@",citizen.fullName];
        
        return cell;
    }
    return nil;
}

@end
