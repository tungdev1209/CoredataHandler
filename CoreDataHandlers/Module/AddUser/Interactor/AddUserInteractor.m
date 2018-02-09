//
//  AddUserInteractor.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "AddUserInteractor.h"
#import "AddUserDetail.h"

@implementation AddUserInteractor

-(void)addUserDetail:(AddUserDetail *)userDetail {
    __weak typeof(self) weakSelf = self;
    [userDetail add:^(BOOL succeed) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.presenter addedUser:succeed];
    }];
}

@end
