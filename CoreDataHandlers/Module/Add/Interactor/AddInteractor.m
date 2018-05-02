//
//  AddInteractor.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AddInteractor.h"
#import "NSObject_Extension.h"

@interface AddInteractor()

@end

@implementation AddInteractor
@synthesize presenter;

- (void)addUserDetail:(AddUserDetail *)userDetail {
    UserModel *mUser = [[UserModel alloc] init];
    [mUser getDataFromObject:userDetail];
    
    weakify(self);
    [[DataHandler shared] local_addUser:mUser completion:^(BOOL succeed, UserModel *user) {
        strongify(self);
        [self.presenter didAddUser:user status:succeed];
    }];
}

@end
