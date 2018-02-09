//
//  FetchUserInteractor.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "FetchUserInteractor.h"
#import "FetchUserListUserDetail.h"

@interface FetchUserInteractor ()

@end

@implementation FetchUserInteractor

-(void)setup:(id<FetchUserInteractorProtocol>)presenter {
    self.presenter = presenter;
}

-(void)fetchUsers {
    __weak typeof(self) weakSelf = self;
    [FetchUserListUserDetail get:^(FetchUserListUserDetail *listUsers) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.presenter receivedUserDetails:listUsers];
    }];
}

@end
