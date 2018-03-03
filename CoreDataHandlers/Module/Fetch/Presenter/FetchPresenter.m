//
//  FetchPresenter.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FetchPresenter.h"
#import "FetchInteractor.h"

@interface FetchPresenter()

@end

@implementation FetchPresenter
@synthesize view = _view;
@synthesize interactor;
@synthesize wireframe;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.interactor = [[FetchInteractor alloc] init];
        self.interactor.presenter = self;
    }
    return self;
}

-(void)setView:(id<FetchPresenterViewProtocol>)view {
    _view = view;
    self.view.presenterFetch = self;
}

- (void)updateListUsers {
    [self.interactor fetchUsers];
}

- (void)didReceiveUserDetails:(FetchUserListUserDetail *)userDetails {
    [self.view showUserDetails:userDetails];
}

@end
