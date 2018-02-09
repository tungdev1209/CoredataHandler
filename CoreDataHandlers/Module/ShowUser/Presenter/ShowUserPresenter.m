//
//  ShowUserPresenter.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "ShowUserPresenter.h"
#import "ShowUserWireframe.h"
#import "ShowUserInteractor.h"

@implementation ShowUserPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interactor = [[ShowUserInteractor alloc] init];
    }
    return self;
}

-(void)setup:(id<ShowUserPresenterViewProtocol>)view wireframe:(id<ShowUserPresenterWireframeProtocol>)wireframe {
    self.view = view;
    self.wireframe = wireframe;
    [self.interactor setup:self];
}

-(void)showUserDetail:(NSString *)name {
    [self.interactor getUserDetailWithName:name];
}

-(void)didGetUserDetail:(ShowUserDetail *)userDetail {
    if (!userDetail) {
        return;
    }
    [self.wireframe showUserDetailScreen:userDetail];
}

@end
