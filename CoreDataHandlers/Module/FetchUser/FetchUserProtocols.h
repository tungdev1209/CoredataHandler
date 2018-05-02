//
//  FetchUserProtocols.h
//  CoreDataHandlers
//
//  Created by apple on 05/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@protocol FetchUserPresenterInteractorProtocol;
@protocol FetchUserPresenterViewProtocol;
@protocol FetchUserPresenterWireframeProtocol;

// View -> Presenter
@protocol FetchUserViewProtocol <NSObject>

@property (nonatomic, weak) id<FetchUserPresenterViewProtocol> view;

-(void)getUserDetail:(NSString *)username;
-(void)getUserDetailWithRole:(NSString *)role;
-(void)getListUsersDetailWithRole:(NSString *)role;

@end

// Interactor -> Presenter
@protocol FetchUserInteractorProtocol <NSObject>

@property (nonatomic, strong) id<FetchUserPresenterInteractorProtocol> interactor;

-(void)didGetUser:(UserModel *)user;
-(void)didGetUser:(UserModel *)user withRole:(NSString *)role;
-(void)didGetListUsers:(NSArray <UserModel *> *)user withRole:(NSString *)role;

@end

// Wireframe -> Presenter
@protocol FetchUserWireframeProtocol <NSObject>

@property (nonatomic, weak) id<FetchUserPresenterWireframeProtocol> wireframe;

@end

// View, Interactor, Wireframe -> Presenter
@protocol FetchUserPresenterInputProtocol <FetchUserViewProtocol, FetchUserInteractorProtocol, FetchUserWireframeProtocol>
@end

// Presenter -> View
@protocol FetchUserPresenterViewProtocol <NSObject>

@property (nonatomic, weak) id<FetchUserViewProtocol> presenterFetchUser;

@optional
-(void)showUserDetail:(UserModel *)user;
-(void)showListUsersDetail:(NSArray<UserModel *> *)users role:(NSString *)role;
-(void)showAdminDetail:(UserModel *)user;
-(void)registerAdmin;

@end

// Presenter -> Interactor
@protocol FetchUserPresenterInteractorProtocol <NSObject>

@property (nonatomic, weak) id<FetchUserInteractorProtocol> presenter;

-(void)getUser:(NSString *)username;
-(void)getUserWithRole:(NSString *)role;
-(void)getListUsersWithRole:(NSString *)role;

@end

// Presenter -> Wireframe
@protocol FetchUserPresenterWireframeProtocol <NSObject>

@property (nonatomic, strong) id<FetchUserWireframeProtocol> presenter;

// should only use for adding dependencies
@property (nonatomic, strong) id<FetchUserPresenterInputProtocol> presenterInput;

@end
