//
//  FetchUserListUserDetail.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "FetchUserListUserDetail.h"
#import "FetchUserDetail.h"
#import "UserModel.h"

@interface FetchUserListUserDetail()

@end

@implementation FetchUserListUserDetail

+(void)get:(ListUserDetailBlock)completion {
    [UserModel get:^(NSArray<UserModel *> * _Nonnull mUsers) {
        FetchUserListUserDetail *list = [[FetchUserListUserDetail alloc] init];
        FetchUserDetail *userDetail;
        for (UserModel *user in mUsers) {
            userDetail = [[FetchUserDetail alloc] init];
            userDetail.name = user.name;
            userDetail.age = user.age;
            [list.listUsers addObject:userDetail];
        }
        if (completion) {
            completion(list);
        }
    }];
}

-(NSMutableArray *)listUsers {
    if (!_listUsers) {
        _listUsers = [NSMutableArray array];
    }
    return _listUsers;
}

@end
