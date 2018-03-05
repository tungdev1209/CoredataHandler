//
//  RootWireframe.m
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "RootWireframe.h"
#import "RootPresenter.h"

#import "ViewController.h"
#import "UserDetailViewController.h"

#import "AddWireframe.h"
#import "FetchWireframe.h"
#import "ShowWireframe.h"
#import "DimissWireframe.h"

@interface RootWireframe ()

@property (nonatomic, weak) UIWindow *window;
@property (nonatomic, weak) UIStoryboard *mainStoryboard;

@property (nonatomic, weak) ViewController *rootVC;
@property (nonatomic, strong) UserDetailViewController *userDetailVC;

@property (nonatomic, strong) FetchWireframe *fetchWireframe;
@property (nonatomic, strong) AddWireframe *addWireframe;
@property (nonatomic, strong) ShowWireframe *showWireframe;
@property (nonatomic, strong) DimissWireframe *dismissWireframe;

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
    self.rootVC = (ViewController *)[AppUtils topViewControllerWithRootViewController:self.window.rootViewController];
    self.mainStoryboard = ((UIViewController *)self.rootVC).storyboard;
    [self addRootViewControllerDependencies];
}

#pragma mark - ViewController
-(void)addRootViewControllerDependencies {
    // add Add module
    self.addWireframe = [[AddWireframe alloc] init];
    self.addWireframe.presenterInput.view = self.rootVC;
    
    // add Fetch module
    self.fetchWireframe = [[FetchWireframe alloc] init];
    self.fetchWireframe.presenterInput.view = self.rootVC;
    
    // add Show module
    self.showWireframe = [[ShowWireframe alloc] init];
    self.showWireframe.presenterInput.view = self.rootVC;
}

#pragma mark - UserDetailViewController
-(void)showUserDetailVCFromRootWithUser:(UserModel *)user {
    ViewController *vc = (ViewController *)self.rootVC;
    UserDetailViewController *userVC = (UserDetailViewController *)self.userDetailVC;
    userVC.userDetail = user;
    [self addUserDetailControllerDependencies];
    [vc presentViewController:userVC animated:YES completion:nil];
}

-(void)didDismissViewController:(UIViewController *)vc {
    if (vc == (UIViewController *)self.userDetailVC) {
        self.dismissWireframe = nil;
        self.userDetailVC = nil;
    }
}

-(void)addUserDetailControllerDependencies {
    self.dismissWireframe = [[DimissWireframe alloc] init];
    self.dismissWireframe.presenterInput.view = self.userDetailVC;
    [self.dismissWireframe setViewController:self.userDetailVC];
}

-(id<UserControllerProtocolInput>)userDetailVC {
    if (!_userDetailVC) {
        _userDetailVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([UserDetailViewController class])];
    }
    return _userDetailVC;
}

@end
