//
//  DimissPresenter.m
//  CoreDataHandlers
//
//  Created by tungnguyen on 03/05/18.
//  Copyright © 2018 tungnguyen. All rights reserved.
//

#import "DimissPresenter.h"
#import "DimissInteractor.h"

@interface DimissPresenter()

@end

@implementation DimissPresenter
@synthesize view = _view;
@synthesize interactor;
@synthesize wireframe;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.interactor = [[DimissInteractor alloc] init];
        self.interactor.presenter = self;
    }
    return self;
}

-(void)setView:(id<DimissPresenterViewProtocol>)view {
	_view = view;
    self.view.presenterDimiss = self;
}

- (void)shouldDimissVC {
    [self.wireframe shouldDismissVC];
}

@end
