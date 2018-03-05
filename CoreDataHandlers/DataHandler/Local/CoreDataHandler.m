//
//  CoreDataHandler.m
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/30/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "CoreDataHandler.h"
#import "CoreDataStackHandler.h"
#import "NSObject_Extension.h"

@interface CoreDataHandler()

@property (nonatomic, strong) CoreDataStackHandler *stackHandler;

@end

@implementation CoreDataHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stackHandler = [[CoreDataStackHandler alloc] init];
    }
    return self;
}

#pragma mark - APP funcs
-(void)getListUsers:(ListUsersBlock)completion {
    [self.stackHandler fetchEntries:[User fetchRequest] withPredicate:nil sortDescriptors:nil completionBlock:^(NSArray *users) {
        NSMutableArray *mUsers = [NSMutableArray array];
        for (User *user in users) {
            [mUsers addObject:[[UserModel alloc] initWithUser:user]];
        }
        if (completion) {
            completion(mUsers);
        }
    }];
}

-(void)getUserWithName:(NSString *)name completion:(GetUserBlock)completion {
    [self.stackHandler fetchEntries:[User fetchRequest] withPredicate:[NSPredicate predicateWithFormat:@"name == %@", name] sortDescriptors:nil completionBlock:^(NSArray *users) {
        UserModel *mUser = nil;
        if (users.firstObject) {
            mUser = [[UserModel alloc] initWithUser:users.firstObject];
        }
        if (completion) {
            completion(mUser);
        }
    }];
}

-(void)addUser:(UserModel *)mUser completion:(SaveUserBlock)completion {
    User *cdUser = (User *)[self.stackHandler newBackgroundEntry:[User class]];
    [mUser sendDataToObject:cdUser];
     
    [self.stackHandler saveEntry:cdUser completion:^(NSError *error) {
        if (error) {
            NSLog(@"save entry failed: %@", error);
        }
        if (completion) {
            completion(!error);
        }
    }];
}

-(NSError *)addUser:(UserModel *)mUser {
    User *cdUser = (User *)[self.stackHandler newEntry:[User class]];
    [mUser sendDataToObject:cdUser];
     
    return [self.stackHandler saveEntry:cdUser];
}

@end
