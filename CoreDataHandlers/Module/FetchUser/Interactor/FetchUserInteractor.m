//
//  FetchUserInteractor.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "FetchUserInteractor.h"
#import "DataHandler.h"
#import "UserModel.h"

@interface FetchUserInteractor ()

@end

@implementation FetchUserInteractor

-(void)fetchUsers {
    __weak typeof(self) weakSelf = self;
    [[DataHandler shared] getListUsersLocal:^(NSArray *users) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        FetchUserDetail *userDetail;
        NSMutableArray *userDetails = [NSMutableArray array];
        for (UserModel *user in users) {
            userDetail = [[FetchUserDetail alloc] init];
            userDetail.name = user.name;
            userDetail.age = user.age;
            [userDetails addObject:userDetail];
        }
        [strongSelf.presenter receivedUserDetails:userDetails];
    }];
}

@end
