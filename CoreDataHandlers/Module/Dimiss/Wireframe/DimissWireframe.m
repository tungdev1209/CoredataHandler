//
//  DimissWireframe.m
//  CoreDataHandlers
//
//  Created by tungnguyen on 03/05/18.
//  Copyright © 2018 tungnguyen. All rights reserved.
//

#import "DimissWireframe.h"
#import "DimissPresenter.h"
#import "RootWireframe.h"

@interface DimissWireframe()

@end

@implementation DimissWireframe
@synthesize presenter;
@synthesize presenterInput;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.presenterInput = [[DimissPresenter alloc] init];
        self.presenter = self.presenterInput;
        self.presenter.wireframe = self;
    }
    return self;
}

-(void)shouldDismissVC {
    weakify(self);
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        strongify(self);
        [[RootWireframe shared] didDismissViewController:self.viewController];
    }];
}

@end
