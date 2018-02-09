//
//  LocalDataHandler.m
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/30/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "LocalDataHandler.h"
#import "CoreDataHandler.h"
#import "NSObject_Extension.h"
#import "UserModel.h"
#import "User+CoreDataProperties.h"

typedef enum : NSUInteger {
    LocalDataHandlerTypeCoredata,
    LocalDataHandlerTypeOther,
} LocalDataHandlerType;

@interface LocalDataHandler()

@property (nonatomic, strong) CoreDataHandler *coredataHandler;
@property (nonatomic, assign) LocalDataHandlerType usingHandlerType;

@end

@implementation LocalDataHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.coredataHandler = [[CoreDataHandler alloc] init];
        self.usingHandlerType = LocalDataHandlerTypeCoredata;
    }
    return self;
}

-(void)getListUsersLocal:(ListUsersBlock)completion {
    if (self.usingHandlerType == LocalDataHandlerTypeCoredata) {
        [self coredataGetListUsersLocal:completion];
    }
}

-(void)getUserLocal:(GetUserBlock)completion withName:(NSString *)name {
    if (self.usingHandlerType == LocalDataHandlerTypeCoredata) {
        [self coredataGetUserLocal:completion withName:name];
    }
}

-(void)addUserLocal:(UserModel *)mUser completion:(SaveUserBlock)completion {
    if (self.usingHandlerType == LocalDataHandlerTypeCoredata) {
        [self coredataAddUserLocal:mUser completion:completion];
    }
}

-(void)coredataGetListUsersLocal:(ListUsersBlock)completion {
    [self.coredataHandler fetchEntries:[User fetchRequest] withPredicate:nil sortDescriptors:nil completionBlock:^(NSArray *users) {
        NSMutableArray *mUsers = [NSMutableArray array];
        for (User *user in users) {
            [mUsers addObject:[[UserModel alloc] initWithUser:user]];
        }
        if (completion) {
            completion(mUsers);
        }
    }];
}

-(void)coredataGetUserLocal:(GetUserBlock)completion withName:(NSString *)name {
    [self.coredataHandler fetchEntries:[User fetchRequest] withPredicate:[NSPredicate predicateWithFormat:@"name == %@", name] sortDescriptors:nil completionBlock:^(NSArray *users) {
        UserModel *mUser = nil;
        if (users.firstObject) {
            mUser = [[UserModel alloc] initWithUser:users.firstObject];
        }
        if (completion) {
            completion(mUser);
        }
    }];
}

-(void)coredataAddUserLocal:(UserModel *)mUser completion:(SaveUserBlock)completion {
    [mUser sendDataToObject:(User *)[self.coredataHandler newEntry:[User class]]];
    [self.coredataHandler saveEntry:^(NSError *error) {
        if (error) {
            NSLog(@"save entry failed: %@", error);
        }
        if (completion) {
            completion(!error);
        }
    }];
}

@end
