//
//  DismissPresenter.m
//  CoreDataHandlers
//
//  Created by apple on 05/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "DismissPresenter.h"
#import "DismissInteractor.h"

@interface DismissPresenter()

@end

@implementation DismissPresenter
@synthesize view = _view;
@synthesize interactor;
@synthesize wireframe;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.interactor = [[DismissInteractor alloc] init];
        self.interactor.presenter = self;
    }
    return self;
}

-(void)setView:(id<DismissPresenterViewProtocol>)view {
	_view = view;
    self.view.presenterDismiss = self;
}

- (void)shouldDimissVC {
    [self.wireframe shouldDismissVC];
}

@end
