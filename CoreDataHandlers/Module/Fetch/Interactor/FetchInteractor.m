//
//  FetchInteractor.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FetchInteractor.h"

@interface FetchInteractor()

@end

@implementation FetchInteractor
@synthesize presenter;

- (void)fetchUsers {
    weakify(self);
    [FetchUserListUserDetail get:^(FetchUserListUserDetail *listUsers) {
        strongify(self);
        [self.presenter didReceiveUserDetails:listUsers];
    }];
}

@end
