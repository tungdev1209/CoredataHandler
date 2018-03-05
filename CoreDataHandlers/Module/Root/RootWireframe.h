//
//  RootWireframe.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RootProtocols.h"

@class UserModel;

@interface RootWireframe : NSObject <RootPresenterProtocol>

@property (nonatomic, weak) id<RootWireframeProtocol> presenter;

+(instancetype)shared;
-(void)setup:(UIWindow *)window;
-(void)showUserDetailVCFromRootWithUser:(UserModel *)user;
-(void)didDismissViewController:(UIViewController *)vc;

@end
