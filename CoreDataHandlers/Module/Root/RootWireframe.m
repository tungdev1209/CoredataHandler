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

#import "AddWireframe.h"
#import "FetchWireframe.h"
#import "ShowWireframe.h"

@interface RootWireframe ()

@property (nonatomic, weak) UIWindow *window;
@property (nonatomic, weak) id<ViewControllerProtocolInput> rootVC;
@property (nonatomic, weak) UIStoryboard *mainStoryboard;

@property (nonatomic, strong) id<FetchPresenterWireframeProtocol> fetchUserWireframe;
@property (nonatomic, strong) id<AddPresenterWireframeProtocol> addUserWireframe;
@property (nonatomic, strong) id<ShowPresenterWireframeProtocol> showUserWireframe;

@property (nonatomic, strong) id<UserControllerProtocolInput> userDetailVC;

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
    self.rootVC = (id<ViewControllerProtocolInput>)[AppUtils topViewControllerWithRootViewController:self.window.rootViewController];
    self.mainStoryboard = ((UIViewController *)self.rootVC).storyboard;
    [self addRootViewControllerDependencies];
}

-(void)showUserDetailVCFromRootWithUser:(UserModel *)user {
    ViewController *vc = (ViewController *)self.rootVC;
    UserDetailViewController *userVC = (UserDetailViewController *)self.userDetailVC;
    userVC.userDetail = user;
    [self addUserDetailControllerDependencies];
    [vc presentViewController:userVC animated:YES completion:nil];
}

-(void)addUserDetailControllerDependencies {
    
}

-(void)addRootViewControllerDependencies {
    // add Add module
    self.addUserWireframe = [[AddWireframe alloc] init];
    self.addUserWireframe.presenterInput.view = self.rootVC;
    
    // add Fetch module
    self.fetchUserWireframe = [[FetchWireframe alloc] init];
    self.fetchUserWireframe.presenterInput.view = self.rootVC;
    
    // add Show module
    self.showUserWireframe = [[ShowWireframe alloc] init];
    self.showUserWireframe.presenterInput.view = self.rootVC;
}

-(id<UserControllerProtocolInput>)userDetailVC {
    if (!_userDetailVC) {
        _userDetailVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([UserDetailViewController class])];
    }
    return _userDetailVC;
}

@end
