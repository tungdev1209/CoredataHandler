//
//  FetchUserPresenter.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "FetchUserPresenter.h"

@implementation FetchUserPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interactor = [[FetchUserInteractor alloc] init];
    }
    return self;
}

-(void)setup:(id<FetchUserPresenterViewProtocol>)view wireframe:(id<FetchUserPresenterWireframeProtocol>)wireframe {
    self.view = view;
    self.wireframe = wireframe;
    [self.interactor setup:self];
}

-(void)updateListUsers {
    [self.interactor fetchUsers];
}

-(void)receivedUserDetails:(FetchUserListUserDetail *)userDetails {
    [self.view showUserDetails:userDetails];
}

@end
