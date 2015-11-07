//
//  InfoController.m
//  cadastre
//
//  Created by Maros Novák on 07/11/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "InfoController.h"
#import "Shareholding.h"
#import "Citizen.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface InfoController () <DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@end

@implementation InfoController

- (void)viewDidLoad
{
    self.title = @"Citizens";
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    [super viewDidLoad];
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

        cell.textLabel.text = [NSString stringWithFormat:@"%@",shareholding.owner.fullName];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Share: %ld%%", (long)shareholding.share.doubleValue];

        return cell;
    } else if ([self.list[0] isKindOfClass:[Citizen class]]) {
        Citizen *citizen = (Citizen *)self.list[indexPath.row];

        cell.textLabel.text = [NSString stringWithFormat:@"%@",citizen.fullName];
        cell.detailTextLabel.text = nil;
        
        return cell;
    }
    return nil;
}

#pragma mark - Empty state

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"emptyCitizen"];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"There are no citizens.";
    
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
    if (self.list.count) {
        return NO;
    }
    return YES;
}

@end
