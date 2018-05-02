//
//  FetchUserPresenter.m
//  CoreDataHandlers
//
//  Created by apple on 05/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FetchUserPresenter.h"
#import "FetchUserInteractor.h"

@interface FetchUserPresenter()

@end

@implementation FetchUserPresenter
@synthesize view = _view;
@synthesize interactor;
@synthesize wireframe;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.interactor = [[FetchUserInteractor alloc] init];
        self.interactor.presenter = self;
    }
    return self;
}

-(void)setView:(id<FetchUserPresenterViewProtocol>)view {
	_view = view;
    self.view.presenterFetchUser = self;
}

-(void)getUserDetail:(NSString *)username {
    [self.interactor getUser:username];
}

-(void)didGetUser:(UserModel *)user {
    [self.view showUserDetail:user];
}

-(void)getUserDetailWithRole:(NSString *)role {
    [self.interactor getUserWithRole:role];
}

-(void)didGetUser:(UserModel *)user withRole:(NSString *)role {
    if ([role isEqualToString:Admin]) {
        if (!user) {
            [self.view registerAdmin];
        }
        else {
            [self.view showAdminDetail:user];
        }
    }
    else {
        [self.view showUserDetail:user];
    }
}

-(void)getListUsersDetailWithRole:(NSString *)role {
    [self.interactor getListUsersWithRole:role];
}

-(void)didGetListUsers:(NSArray<UserModel *> *)users withRole:(NSString *)role {
    [self.view showListUsersDetail:users role:role];
}

@end
