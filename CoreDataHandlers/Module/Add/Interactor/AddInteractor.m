//
//  AddInteractor.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AddInteractor.h"

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
