//
//  LocalDataHandler.m
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/30/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "LocalDataHandler.h"
#import "CoreDataHandler.h"

#import "UserModel.h"

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

@end
