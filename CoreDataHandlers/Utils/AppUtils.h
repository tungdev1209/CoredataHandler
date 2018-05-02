//
//  AppUtils.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define weakify(var) __weak typeof(var) weak_##var = var
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = weak_##var \
_Pragma("clang diagnostic pop")

@interface AppUtils : NSObject

+(UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootVC;

@end
