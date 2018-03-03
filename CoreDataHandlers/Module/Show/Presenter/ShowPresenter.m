//
//  ShowPresenter.m
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ShowPresenter.h"
#import "ShowInteractor.h"

@interface ShowPresenter()

@end

@implementation ShowPresenter
@synthesize view;
@synthesize interactor;
@synthesize wireframe;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialize dependencies
        self.interactor = [[ShowInteractor alloc] init];
        self.interactor.presenter = self;
    }
    return self;
}

-(void)setView:(id<ShowPresenterViewProtocol>)view {
    [self setValue:view forKey:@"view"];
    self.view.presenterShow = self;
}

@end
