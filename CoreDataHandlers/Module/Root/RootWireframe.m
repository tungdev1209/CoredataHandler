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

#import "ViewController.h"
#import "UserDetailViewController.h"

#import "FetchUserWireframe.h"
#import "AddUserWireframe.h"
#import "ShowUserWireframe.h"

@interface RootWireframe ()

@property (nonatomic, weak) UIWindow *window;
@property (nonatomic, weak) UIViewController *rootVC;
@property (nonatomic, strong) FetchUserWireframe *fetchUserWireframe;
@property (nonatomic, strong) AddUserWireframe *addUserWireframe;
@property (nonatomic, strong) ShowUserWireframe *showUserWireframe;
@property (nonatomic, strong) UserDetailViewController *userDetailVC;

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
    self.rootVC = [AppUtils topViewControllerWithRootViewController:self.window.rootViewController];
    [self initializeRootViewControllerWithDependencies:self.rootVC];
}

-(void)initializeRootViewControllerWithDependencies:(UIViewController *)vc {
    self.addUserWireframe = [[AddUserWireframe alloc] init];
    self.showUserWireframe = [[ShowUserWireframe alloc] init];
    self.fetchUserWireframe = [[FetchUserWireframe alloc] init];
    
    if ([vc conformsToProtocol:@protocol(RootViewProtocol)]) {
        NSMutableArray *dependencies = [NSMutableArray array];
        [dependencies addObject:self.addUserWireframe.presenter];
        [dependencies addObject:self.showUserWireframe.presenter];
        [dependencies addObject:self.fetchUserWireframe.presenter];
        [(id<RootViewProtocol>)vc addDependencies:dependencies];
    }
    if ([vc conformsToProtocol:@protocol(AddUserPresenterViewProtocol)]) {
        [self.addUserWireframe.presenter setup:(id<AddUserPresenterViewProtocol>)vc wireframe:self.addUserWireframe];
    }
    if ([vc conformsToProtocol:@protocol(AddUserPresenterViewProtocol)]) {
        [self.fetchUserWireframe.presenter setup:(id<FetchUserPresenterViewProtocol>)vc wireframe:self.fetchUserWireframe];
    }
    if ([vc conformsToProtocol:@protocol(AddUserPresenterViewProtocol)]) {
        [self.showUserWireframe.presenter setup:(id<ShowUserPresenterViewProtocol>)vc wireframe:self.showUserWireframe];
    }
}

-(void)showUserDetailVCFromRoot:(ShowUserDetail *)userDetail {
    self.userDetailVC = [self.rootVC.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([UserDetailViewController class])];
    self.userDetailVC.userDetail = userDetail;
    [self.rootVC presentViewController:self.userDetailVC animated:YES completion:nil];
}

@end
