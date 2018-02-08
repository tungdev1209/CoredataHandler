//
//  FetchUserPresenter.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "FetchUserPresenter.h"

@implementation FetchUserPresenter

-(void)setup:(id)view {
    if (![view conformsToProtocol:@protocol(FetchUserPresenterViewProtocol)]) {
        return;
    }
    FetchUserWireframe *wireframe = [[FetchUserWireframe alloc] init];
    FetchUserInteractor *interactor = [[FetchUserInteractor alloc] init];
    
    self.wireframe = wireframe;
    self.interactor = interactor;
    self.view = view;
    
    wireframe.presenter = self;
    interactor.presenter = self;
}

-(void)updateListUsers {
    [self.interactor fetchUsers];
}

-(void)receivedUserDetails:(NSArray *)userDetails {
    [self.view showUserDetails:userDetails];
}

@end
