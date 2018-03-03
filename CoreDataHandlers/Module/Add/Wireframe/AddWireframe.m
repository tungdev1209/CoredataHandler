//
//  AddWireframe.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AddWireframe.h"
#import "AddPresenter.h"

@interface AddWireframe()

@end

@implementation AddWireframe
@synthesize presenter;
@synthesize presenterInput;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.presenterInput = [[AddPresenter alloc] init];
        self.presenter = self.presenterInput;
        self.presenter.wireframe = self;
    }
    return self;
}

@end
