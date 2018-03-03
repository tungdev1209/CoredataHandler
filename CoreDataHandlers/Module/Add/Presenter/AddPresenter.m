//
//  AddPresenter.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AddPresenter.h"
#import "AddInteractor.h"

@interface AddPresenter()

@end

@implementation AddPresenter
@synthesize view = _view;
@synthesize interactor;
@synthesize wireframe;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.interactor = [[AddInteractor alloc] init];
        self.interactor.presenter = self;
    }
    return self;
}

-(void)setView:(id<AddPresenterViewProtocol>)view {
    _view = view;
    self.view.presenterAdd = self;
}

- (void)addUserDetail:(AddUserDetail *)userDetail {
    [self.interactor addUserDetail:userDetail];
}

- (void)didAddUser:(BOOL)result {
    if (!result) {
        [self.view showAlertAddingFail];
    }
    else {
        [self.view refreshList];
    }
}

@end
