//
//  UpdateWireframe.m
//  CoreDataHandlers
//
//  Created by apple on 04/30/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UpdateWireframe.h"
#import "UpdatePresenter.h"

@interface UpdateWireframe()

@end

@implementation UpdateWireframe
@synthesize presenter;
@synthesize presenterInput;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.presenterInput = [[UpdatePresenter alloc] init];
        self.presenter = self.presenterInput;
        self.presenter.wireframe = self;
    }
    return self;
}

@end
