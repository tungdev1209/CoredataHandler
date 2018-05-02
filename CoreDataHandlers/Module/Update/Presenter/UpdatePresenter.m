//
//  UpdatePresenter.m
//  CoreDataHandlers
//
//  Created by apple on 04/30/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UpdatePresenter.h"
#import "UpdateInteractor.h"

@interface UpdatePresenter()

@end

@implementation UpdatePresenter
@synthesize view = _view;
@synthesize interactor;
@synthesize wireframe;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.interactor = [[UpdateInteractor alloc] init];
        self.interactor.presenter = self;
    }
    return self;
}

-(void)setView:(id<UpdatePresenterViewProtocol>)view {
	_view = view;
    self.view.presenterUpdate = self;
}

-(void)updateUserDetail:(UserModel *)user {
    [self.interactor updateUserDetail:user];
}

-(void)didUpdateUserDetail:(BOOL)succeed {
    if (succeed) {
        [self.view showSuccessAlert];
    }
    else {
        [self.view showFailAlert:@"fail"];
    }
}

@end
