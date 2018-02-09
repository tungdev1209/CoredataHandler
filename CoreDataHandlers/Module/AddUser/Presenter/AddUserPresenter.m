//
//  AddUserPresenter.m
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "AddUserPresenter.h"
#import "AddUserWireframe.h"
#import "AddUserInteractor.h"
#import "AddUserDetail.h"

@implementation AddUserPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interactor = [[AddUserInteractor alloc] init];
    }
    return self;
}

-(void)setup:(id<AddUserPresenterViewProtocol>)view wireframe:(id<AddUserPresenterWireframeProtocol>)wireframe {
    self.wireframe = wireframe;
    self.view = view;
    [self.interactor setup:self];
}

-(void)addUserDetail:(AddUserDetail *)userDetail {
    [self.interactor addUserDetail:userDetail];
}

-(void)addedUser:(BOOL)result {
    if (!result) {
        [self.view showAlertAddingFail];
    }
    else {
        [self.view refreshList];
    }
}

@end
