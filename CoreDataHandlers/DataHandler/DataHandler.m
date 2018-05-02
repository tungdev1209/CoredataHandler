//
//  DataHandler.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "DataHandler.h"
#import "LocalDataHandler.h"
#import "RemoteDataHandler.h"
#import "UserModel.h"
#import "NSObject_Extension.h"

@interface DataHandler ()

@property (nonatomic, strong) RemoteDataHandler *remoteHandler;
@property (nonatomic, strong) LocalDataHandler *localHandler;

@end

@implementation DataHandler

+(instancetype)shared {
    static dispatch_once_t onceToken;
    static DataHandler *h = nil;
    dispatch_once(&onceToken, ^{
        h = [[DataHandler alloc] init];
    });
    return h;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.localHandler = [LocalDataHandler getHandler];
        self.remoteHandler = [RemoteDataHandler getHandler];
    }
    return self;
}

#pragma mark - Local funcs
-(void)local_getUserWithPredicate:(NSPredicate *)predicate completion:(GetUserBlock)completion {
    [self.localHandler getUserWithPredicate:predicate completion:^(UserModel * _Nullable mUser) {
        if ([mUser.role isEqualToString:Admin]) {
            [AdminUser getDataFromObject:mUser];
        }
        if (completion) {
            completion(mUser);
        }
    }];
}

-(void)local_getListUsersWithPredicate:(NSPredicate *)predicate completion:(ListUsersBlock)completion {
    [self.localHandler getListUsersWithPredicate:predicate completion:completion];
}

-(NSError *)local_addUser:(UserModel *)mUser {
    return [self.localHandler addUser:mUser];
}

-(void)local_addUser:(UserModel *)mUser completion:(SaveUserBlock)completion {
    [self.localHandler addUser:mUser completion:^(BOOL succeed, UserModel *user) {
        if ([user.role isEqualToString:Admin]) {
            [AdminUser getDataFromObject:user];
        }
        if (completion) {
            completion(succeed, user);
        }
    }];
}

-(void)local_updateUser:(UserModel *)mUser completion:(SaveUserBlock)completion {
    [self.localHandler updateUser:mUser completion:^(BOOL succeed, UserModel *user) {
        if ([user.role isEqualToString:Admin]) {
            [AdminUser getDataFromObject:user];
        }
        if (completion) {
            completion(succeed, user);
        }
    }];
}

@end
