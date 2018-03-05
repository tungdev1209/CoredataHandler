//
//  ShowInteractor.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ShowInteractor.h"

@interface ShowInteractor()

@end

@implementation ShowInteractor
@synthesize presenter;

- (void)getUser:(NSString *)username {
    weakify(self);
    [UserModel getUserWithName:username completion:^(UserModel * _Nullable mUser) {
        strongify(self);
        [self.presenter didGetUser:mUser];
    }];
}

@end
