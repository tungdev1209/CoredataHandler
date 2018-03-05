//
//  AddInteractor.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AddInteractor.h"

#define weakify(var) __weak typeof(var) weak_##var = var;
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = weak_##var; \
_Pragma("clang diagnostic pop")

@interface AddInteractor()

@end

@implementation AddInteractor
@synthesize presenter;

- (void)addUserDetail:(AddUserDetail *)userDetail {
    weakify(self);
    [userDetail add:^(BOOL succeed) {
        strongify(self);
        [self.presenter didAddUser:succeed];
    }];
}

@end
