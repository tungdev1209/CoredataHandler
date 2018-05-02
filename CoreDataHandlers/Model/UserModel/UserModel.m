//
//  UserModel.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "UserModel.h"
#import "NSObject_Extension.h"
#import "DataHandler.h"

@interface UserModel()

@property (nonatomic, strong) User *user;

@end

@implementation UserModel

+(instancetype)shareUser {
    static UserModel *u = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        u = [[UserModel alloc] init];
    });
    return u;
}

- (instancetype)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        self.user = user;
        [self getDataFromObject:user];
    }
    return self;
}

-(User *)getCoreUser {
    return self.user;
}

@end
