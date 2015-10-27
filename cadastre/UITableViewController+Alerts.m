//
//  UITableViewController+Alerts.m
//  cadastre
//
//  Created by Maros Novák on 27/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "UITableViewController+Alerts.h"
#import "RKDropdownAlert.h"

@implementation UITableViewController (Alerts)

- (void)showSuccessAlertWithMessage:(NSString *)message
{
    [RKDropdownAlert title:message backgroundColor:[UIColor colorWithRed:0.39 green:0.71 blue:0.28 alpha:1] textColor:[UIColor whiteColor] time:2];
}

- (void)showNotifyAlertWithMessage:(NSString *)message
{
    [RKDropdownAlert title:message time:2];
}

- (void)showWarningAlertWithMessage:(NSString *)message
{
    [RKDropdownAlert title:message backgroundColor:[UIColor colorWithRed:0.87 green:0.14 blue:0.16 alpha:1] textColor:[UIColor whiteColor] time:2];
}

@end
