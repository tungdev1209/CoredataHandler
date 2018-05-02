//
//  ShowProtocols.h
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@protocol ShowPresenterInteractorProtocol;
@protocol ShowPresenterViewProtocol;
@protocol ShowPresenterWireframeProtocol;

// View -> Presenter
@protocol ShowViewProtocol <NSObject>

@property (nonatomic, weak) id<ShowPresenterViewProtocol> view;

-(void)showUserDetail:(NSString *)username;

@end

// Interactor -> Presenter
@protocol ShowInteractorProtocol <NSObject>

@property (nonatomic, strong) id<ShowPresenterInteractorProtocol> interactor;

@end

// Wireframe -> Presenter
@protocol ShowWireframeProtocol <NSObject>

@property (nonatomic, weak) id<ShowPresenterWireframeProtocol> wireframe;

@end

// View, Interactor, Wireframe -> Presenter
@protocol ShowPresenterInputProtocol <ShowViewProtocol, ShowInteractorProtocol, ShowWireframeProtocol>
@end

// Presenter -> View
@protocol ShowPresenterViewProtocol <NSObject>

@property (nonatomic, weak) id<ShowViewProtocol> presenterShow;

@end

// Presenter -> Interactor
@protocol ShowPresenterInteractorProtocol <NSObject>

@property (nonatomic, weak) id<ShowInteractorProtocol> presenter;

@end

// Presenter -> Wireframe
@protocol ShowPresenterWireframeProtocol <NSObject>

@property (nonatomic, strong) id<ShowWireframeProtocol> presenter;

// should only use for adding dependencies
@property (nonatomic, strong) id<ShowPresenterInputProtocol> presenterInput;

-(void)showUserDetailVC:(NSString *)username;

@end
