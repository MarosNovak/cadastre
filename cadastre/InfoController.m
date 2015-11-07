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

@interface InfoController ()

@end

@implementation InfoController

- (void)viewDidLoad
{ 
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
