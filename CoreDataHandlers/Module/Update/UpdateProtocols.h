//
//  UpdateProtocols.h
//  CoreDataHandlers
//
//  Created by apple on 04/30/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "NSObject_Extension.h"

@protocol UpdatePresenterInteractorProtocol;
@protocol UpdatePresenterViewProtocol;
@protocol UpdatePresenterWireframeProtocol;

// View -> Presenter
@protocol UpdateViewProtocol <NSObject>

@property (nonatomic, weak) id<UpdatePresenterViewProtocol> view;

-(void)updateUserDetail:(UserModel *)user;

@end

// Interactor -> Presenter
@protocol UpdateInteractorProtocol <NSObject>

@property (nonatomic, strong) id<UpdatePresenterInteractorProtocol> interactor;

-(void)didUpdateUserDetail:(BOOL)succeed;

@end

// Wireframe -> Presenter
@protocol UpdateWireframeProtocol <NSObject>

@property (nonatomic, weak) id<UpdatePresenterWireframeProtocol> wireframe;

@end

// View, Interactor, Wireframe -> Presenter
@protocol UpdatePresenterInputProtocol <UpdateViewProtocol, UpdateInteractorProtocol, UpdateWireframeProtocol>
@end

// Presenter -> View
@protocol UpdatePresenterViewProtocol <NSObject>

@property (nonatomic, weak) id<UpdateViewProtocol> presenterUpdate;

-(void)showFailAlert:(NSString *)message;
-(void)showSuccessAlert;

@end

// Presenter -> Interactor
@protocol UpdatePresenterInteractorProtocol <NSObject>

@property (nonatomic, weak) id<UpdateInteractorProtocol> presenter;

-(void)updateUserDetail:(UserModel *)user;

@end

// Presenter -> Wireframe
@protocol UpdatePresenterWireframeProtocol <NSObject>

@property (nonatomic, strong) id<UpdateWireframeProtocol> presenter;

// should only use for adding dependencies
@property (nonatomic, strong) id<UpdatePresenterInputProtocol> presenterInput;

@end
