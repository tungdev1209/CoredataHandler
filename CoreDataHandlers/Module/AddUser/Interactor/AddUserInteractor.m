//
//  AddUserInteractor.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "AddUserInteractor.h"
#import "AddUserDetail.h"
#import "UserModel.h"
#import "DataHandler.h"

@implementation AddUserInteractor

-(void)addUserDetail:(AddUserDetail *)userDetail {
    UserModel *mUser = [[UserModel alloc] init];
    mUser.name = userDetail.name;
    mUser.age = userDetail.age;
    __weak typeof(self) weakSelf = self;
    [[DataHandler shared] addUserLocal:mUser completion:^(BOOL succeed) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.presenter addedUser:succeed];
    }];
}

@end
