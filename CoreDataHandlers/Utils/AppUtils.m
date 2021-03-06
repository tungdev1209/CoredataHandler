//
//  AppUtils.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "AppUtils.h"

@implementation AppUtils

+(UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootVC {
    if (rootVC == nil) {
        return nil;
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        return [self topViewControllerWithRootViewController:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        return [self topViewControllerWithRootViewController:[(UINavigationController *)rootVC visibleViewController]];
    }
    else if (rootVC.presentedViewController != nil) {
        return [self topViewControllerWithRootViewController:rootVC.presentedViewController];
    }
    return rootVC;
}

@end
