//
//  PropertiesController.m
//  cadastre
//
//  Created by Maros Novák on 27/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "PropertiesController.h"
#import "Property.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface PropertiesController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation PropertiesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
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

#pragma mark - Empty state

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"emptyHouse"];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"There are no properties.";
    
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
    if (self.properties.count) {
        return NO;
    }
    return YES;
}

@end
