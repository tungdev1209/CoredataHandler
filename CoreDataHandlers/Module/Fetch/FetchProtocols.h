//
//  FetchProtocols.h
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchUserDetail.h"
#import "FetchUserListUserDetail.h"

@protocol FetchPresenterInteractorProtocol;
@protocol FetchPresenterViewProtocol;
@protocol FetchPresenterWireframeProtocol;

// View -> Presenter
@protocol FetchViewProtocol <NSObject>

@property (nonatomic, weak) id<FetchPresenterViewProtocol> view;

-(void)updateListUsers;

@end

// Interactor -> Presenter
@protocol FetchInteractorProtocol <NSObject>

@property (nonatomic, strong) id<FetchPresenterInteractorProtocol> interactor;

-(void)didReceiveUserDetails:(FetchUserListUserDetail *)userDetails;

@end

// Wireframe -> Presenter
@protocol FetchWireframeProtocol <NSObject>

@property (nonatomic, weak) id<FetchPresenterWireframeProtocol> wireframe;

@end

// View, Interactor, Wireframe -> Presenter
@protocol FetchPresenterInputProtocol <FetchViewProtocol, FetchInteractorProtocol, FetchWireframeProtocol>
@end

// Presenter -> View
@protocol FetchPresenterViewProtocol <NSObject>

@property (nonatomic, weak) id<FetchViewProtocol> presenterFetch;

-(void)showUserDetails:(FetchUserListUserDetail *)userDetails;

@end

// Presenter -> Interactor
@protocol FetchPresenterInteractorProtocol <NSObject>

@property (nonatomic, weak) id<FetchInteractorProtocol> presenter;

-(void)fetchUsers;

@end

// Presenter -> Wireframe
@protocol FetchPresenterWireframeProtocol <NSObject>

@property (nonatomic, strong) id<FetchWireframeProtocol> presenter;

// should only use for adding dependencies
@property (nonatomic, strong) id<FetchPresenterInputProtocol> presenterInput;

@end
