//
//  FetchUserWireframe.m
//  CoreDataHandlers
//
//  Created by apple on 05/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FetchUserWireframe.h"
#import "FetchUserPresenter.h"

@interface FetchUserWireframe()

@end

@implementation FetchUserWireframe
@synthesize presenter;
@synthesize presenterInput;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.presenterInput = [[FetchUserPresenter alloc] init];
        self.presenter = self.presenterInput;
        self.presenter.wireframe = self;
    }
    return self;
}

@end
