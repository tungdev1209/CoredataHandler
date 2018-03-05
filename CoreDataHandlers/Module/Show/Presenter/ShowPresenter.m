//
//  ShowPresenter.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ShowPresenter.h"
#import "ShowInteractor.h"

@interface ShowPresenter()

@end

@implementation ShowPresenter
@synthesize view = _view;
@synthesize interactor;
@synthesize wireframe;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.interactor = [[ShowInteractor alloc] init];
        self.interactor.presenter = self;
    }
    return self;
}

-(void)setView:(id<ShowPresenterViewProtocol>)view {
    _view = view;
    self.view.presenterShow = self;
}

- (void)showUserDetail:(NSString *)username {
    [self.interactor getUser:username];
}

- (void)didGetUser:(UserModel *)user {
    [self.wireframe showUserDetailVC:user];
}

@end
