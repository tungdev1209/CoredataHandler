//
//  AddProtocols.h
//  CoreDataHandlers
//
//  Created by apple on 03/03/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddUserDetail.h"

@protocol AddPresenterInteractorProtocol;
@protocol AddPresenterViewProtocol;
@protocol AddPresenterWireframeProtocol;

// View -> Presenter
@protocol AddViewProtocol <NSObject>

@property (nonatomic, weak) id<AddPresenterViewProtocol> view;

-(void)addUserDetail:(AddUserDetail *)userDetail;

@end

// Interactor -> Presenter
@protocol AddInteractorProtocol <NSObject>

@property (nonatomic, strong) id<AddPresenterInteractorProtocol> interactor;

-(void)didAddUser:(UserModel *)userDetail status:(BOOL)result;

@end

// Wireframe -> Presenter
@protocol AddWireframeProtocol <NSObject>

@property (nonatomic, weak) id<AddPresenterWireframeProtocol> wireframe;

@end

// View, Interactor, Wireframe -> Presenter
@protocol AddPresenterInputProtocol <AddViewProtocol, AddInteractorProtocol, AddWireframeProtocol>
@end

// Presenter -> View
@protocol AddPresenterViewProtocol <NSObject>

@property (nonatomic, weak) id<AddViewProtocol> presenterAdd;

-(void)showAlertAddingFailWithUser:(UserModel *)userDetail;
-(void)didAddUser:(UserModel *)user;
-(void)refreshListMembers;
-(void)getListMembers;

@end

// Presenter -> Interactor
@protocol AddPresenterInteractorProtocol <NSObject>

@property (nonatomic, weak) id<AddInteractorProtocol> presenter;

-(void)addUserDetail:(AddUserDetail *)userDetail;

@end

// Presenter -> Wireframe
@protocol AddPresenterWireframeProtocol <NSObject>

@property (nonatomic, strong) id<AddWireframeProtocol> presenter;

// should only use for adding dependencies
@property (nonatomic, strong) id<AddPresenterInputProtocol> presenterInput;

@end
