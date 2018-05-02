//
//  DismissWireframe.m
//  CoreDataHandlers
//
//  Created by apple on 05/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "DismissWireframe.h"
#import "DismissPresenter.h"
#import "RootWireframe.h"

@interface DismissWireframe()

@end

@implementation DismissWireframe
@synthesize presenter;
@synthesize presenterInput;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.presenterInput = [[DismissPresenter alloc] init];
        self.presenter = self.presenterInput;
        self.presenter.wireframe = self;
    }
    return self;
}

-(void)shouldDismissVC {
    [[RootWireframe shared] dismissUserDetailViewController];
}

@end
