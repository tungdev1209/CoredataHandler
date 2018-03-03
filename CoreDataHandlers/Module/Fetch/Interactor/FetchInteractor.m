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
    __weak typeof(self) weakSelf = self;
    [FetchUserListUserDetail get:^(FetchUserListUserDetail *listUsers) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.presenter didReceiveUserDetails:listUsers];
    }];
}

@end
