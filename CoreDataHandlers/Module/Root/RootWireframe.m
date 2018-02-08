//
//  RootWireframe.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "RootWireframe.h"
#import "RootPresenter.h"
#import "AppUtils.h"

#import "FetchUserPresenter.h"
#import "AddUserPresenter.h"

@interface RootWireframe ()

@property (nonatomic, weak) UIWindow *window;

@end

@implementation RootWireframe

+(instancetype)shared {
    static dispatch_once_t onceToken;
    static RootWireframe *w = nil;
    dispatch_once(&onceToken, ^{
        w = [[RootWireframe alloc] init];
    });
    return w;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        RootPresenter *presenter = [[RootPresenter alloc] init];
        self.presenter = presenter;
        presenter.wireframe = self;
    }
    return self;
}

-(void)setup:(UIWindow *)window {
    self.window = window;
    UIViewController *vc = [AppUtils topViewControllerWithRootViewController:self.window.rootViewController];
    [self initializeRootViewControllerDependencies:vc];
}

-(void)initializeRootViewControllerDependencies:(UIViewController *)vc {
    NSMutableArray *dependencies = [NSMutableArray array];
    if ([vc conformsToProtocol:@protocol(RootViewProtocol)]) {
        [dependencies addObject:[[FetchUserPresenter alloc] init]];
        [dependencies addObject:[[AddUserPresenter alloc] init]];
    }
    [(id<RootViewProtocol>)vc startup:dependencies];
}

@end
