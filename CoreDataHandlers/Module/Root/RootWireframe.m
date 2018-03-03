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

@interface RootWireframe ()

@property (nonatomic, weak) UIWindow *window;
@property (nonatomic, weak) id<ViewControllerProtocolInput> rootVC;
@property (nonatomic, strong) id<FetchPresenterWireframeProtocol> fetchUserWireframe;
@property (nonatomic, strong) id<AddPresenterWireframeProtocol> addUserWireframe;
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
    self.rootVC = (id<ViewControllerProtocolInput>)[AppUtils topViewControllerWithRootViewController:self.window.rootViewController];
    [self addRootViewControllerDependencies];
}

-(void)addRootViewControllerDependencies {
    // add Add module
    self.addUserWireframe = [[AddWireframe alloc] init];
    self.addUserWireframe.presenterInput.view = self.rootVC;
    
    // add Fetch module
    self.fetchUserWireframe = [[FetchWireframe alloc] init];
    self.fetchUserWireframe.presenterInput.view = self.rootVC;
}

-(void)showUserDetailVCFromRoot:(ShowUserDetail *)userDetail {
    UIViewController *vc = (UIViewController *)self.rootVC;
    self.userDetailVC = [vc.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([UserDetailViewController class])];
    self.userDetailVC.userDetail = userDetail;
    [vc presentViewController:self.userDetailVC animated:YES completion:nil];
}

@end
