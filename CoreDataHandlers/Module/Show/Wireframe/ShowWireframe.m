//
//  ShowWireframe.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ShowWireframe.h"
#import "ShowPresenter.h"
#import "RootWireframe.h"

@interface ShowWireframe()

@end

@implementation ShowWireframe
@synthesize presenter;
@synthesize presenterInput;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.presenterInput = [[ShowPresenter alloc] init];
        self.presenter = self.presenterInput;
        self.presenter.wireframe = self;
    }
    return self;
}

- (void)showUserDetailVC:(UserModel *)user {
    [[RootWireframe shared] showUserDetailVCFromRootWithUser:user];
}

@end
