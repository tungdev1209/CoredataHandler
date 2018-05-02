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
#import "ShowWireframe.h"
#import "DismissWireframe.h"
#import "UpdateWireframe.h"
#import "FetchUserWireframe.h"

#define sc(x) NSStringFromClass([x class])
#define eqs(x, y) [x isEqualToString:y]

@interface RootWireframe ()

@property (nonatomic, weak) UIWindow *window;
@property (nonatomic, weak) UIStoryboard *mainStoryboard;

@property (nonatomic, weak) ViewController<ViewControllerProtocolInput> *rootVC;
@property (nonatomic, strong) UserDetailViewController<UserControllerProtocolInput> *userDetailVC;

@property (nonatomic, strong) AddWireframe *addWireframe;
@property (nonatomic, strong) ShowWireframe *showWireframe;
@property (nonatomic, strong) DismissWireframe *dismissWireframe;
@property (nonatomic, strong) UpdateWireframe *updateWireframe;
@property (nonatomic, strong) FetchUserWireframe *fetchUserWireframe;

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
    self.rootVC = (ViewController <ViewControllerProtocolInput> *)[AppUtils topViewControllerWithRootViewController:self.window.rootViewController];
    self.mainStoryboard = ((UIViewController *)self.rootVC).storyboard;
    [self addDependencies:@[sc(AddWireframe),
                            sc(ShowWireframe),
                            sc(FetchUserWireframe)]
                    forVC:self.rootVC];
}

#pragma mark - Dependencies
-(void)addDependencies:(NSArray *)deps forVC:(UIViewController <ViewControllerProtocolInput, UserControllerProtocolInput> *)vc {
    for (NSString *className in deps) {
        if (eqs(className, sc(FetchUserWireframe))) {
            self.fetchUserWireframe = [[FetchUserWireframe alloc] init];
            self.fetchUserWireframe.presenterInput.view = vc;
        }
        else if (eqs(className, sc(AddWireframe))) {
            self.addWireframe = [[AddWireframe alloc] init];
            self.addWireframe.presenterInput.view = vc;
        }
        else if (eqs(className, sc(ShowWireframe))) {
            self.showWireframe = [[ShowWireframe alloc] init];
            self.showWireframe.presenterInput.view = vc;
        }
        else if (eqs(className, sc(DismissWireframe))) {
            self.dismissWireframe = [[DismissWireframe alloc] init];
            self.dismissWireframe.presenterInput.view = vc;
        }
        else if (eqs(className, sc(UpdateWireframe))) {
            self.updateWireframe = [[UpdateWireframe alloc] init];
            self.updateWireframe.presenterInput.view = vc;
        }
    }
}

#pragma mark - UserDetailViewController
-(void)showUserDetailVCFromRootWithUserName:(NSString *)username {
    self.userDetailVC.username = username;
    [self addDependencies:@[sc(DismissWireframe),
                            sc(FetchUserWireframe),
                            sc(UpdateWireframe)]
                    forVC:self.userDetailVC];
    [self.rootVC presentViewController:self.userDetailVC animated:YES completion:nil];
}

-(void)dismissUserDetailViewController {
    weakify(self);
    [self.userDetailVC dismissViewControllerAnimated:YES completion:^{
        strongify(self);
        self.dismissWireframe = nil;
        self.userDetailVC = nil;
    }];
}

-(UserDetailViewController<UserControllerProtocolInput> *)userDetailVC {
    if (!_userDetailVC) {
        _userDetailVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([UserDetailViewController class])];
    }
    return _userDetailVC;
}

@end
