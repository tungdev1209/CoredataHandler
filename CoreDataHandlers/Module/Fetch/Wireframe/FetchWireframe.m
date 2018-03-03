//
//  FetchWireframe.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FetchWireframe.h"
#import "FetchPresenter.h"

@interface FetchWireframe()

@end

@implementation FetchWireframe
@synthesize presenter;
@synthesize presenterInput;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.presenterInput = [[FetchPresenter alloc] init];
        self.presenter = self.presenterInput;
        self.presenter.wireframe = self;
    }
    return self;
}

@end
