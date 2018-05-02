//
//  FetchUserInteractor.m
//  CoreDataHandlers
//
//  Created by apple on 05/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FetchUserInteractor.h"
#import "NSObject_Extension.h"

@interface FetchUserInteractor()

@end

@implementation FetchUserInteractor
@synthesize presenter;

- (void)getUser:(NSString *)username {
    weakify(self);
    [[DataHandler shared] local_getUserWithPredicate:[NSPredicate predicateWithFormat:@"name == %@", username] completion:^(UserModel * _Nullable mUser) {
        strongify(self);
        [self.presenter didGetUser:mUser];
    }];
}

-(void)getUserWithRole:(NSString *)role {
    weakify(self);
    [[DataHandler shared] local_getUserWithPredicate:[NSPredicate predicateWithFormat:@"role == %@", role] completion:^(UserModel * _Nullable mUser) {
        strongify(self);
        [self.presenter didGetUser:mUser withRole:role];
    }];
}

-(void)getListUsersWithRole:(NSString *)role {
    weakify(self);
    [[DataHandler shared] local_getListUsersWithPredicate:[NSPredicate predicateWithFormat:@"role == %@", role] completion:^(NSArray<UserModel *> * _Nonnull mUsers) {
        strongify(self);
        [self.presenter didGetListUsers:mUsers withRole:role];
    }];
}

@end
