//
//  ShowUserInteractor.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "ShowUserInteractor.h"

@implementation ShowUserInteractor

-(void)setup:(id<ShowUserInteractorProtocol>)presenter {
    self.presenter = presenter;
}

-(void)getUserDetailWithName:(NSString *)name {
    __weak typeof(self) weakSelf = self;
    [ShowUserDetail get:^(ShowUserDetail *userDetail) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.presenter didGetUserDetail:userDetail];
    } withName:name];
}

@end
