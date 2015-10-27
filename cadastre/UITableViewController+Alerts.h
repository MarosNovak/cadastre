//
//  UITableViewController+Alerts.h
//  cadastre
//
//  Created by Maros Novák on 27/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewController (Alerts)

- (void)showSuccessAlertWithMessage:(NSString *)message;

- (void)showNotifyAlertWithMessage:(NSString *)message;

- (void)showWarningAlertWithMessage:(NSString *)message;

@end
