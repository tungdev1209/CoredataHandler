//
//  DismissProtocols.h
//  CoreDataHandlers
//
//  Created by apple on 05/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DismissPresenterInteractorProtocol;
@protocol DismissPresenterViewProtocol;
@protocol DismissPresenterWireframeProtocol;

// View -> Presenter
@protocol DismissViewProtocol <NSObject>

@property (nonatomic, weak) id<DismissPresenterViewProtocol> view;

-(void)shouldDimissVC;

@end

// Interactor -> Presenter
@protocol DismissInteractorProtocol <NSObject>

@property (nonatomic, strong) id<DismissPresenterInteractorProtocol> interactor;

@end

// Wireframe -> Presenter
@protocol DismissWireframeProtocol <NSObject>

@property (nonatomic, weak) id<DismissPresenterWireframeProtocol> wireframe;

@end

// View, Interactor, Wireframe -> Presenter
@protocol DismissPresenterInputProtocol <DismissViewProtocol, DismissInteractorProtocol, DismissWireframeProtocol>
@end

// Presenter -> View
@protocol DismissPresenterViewProtocol <NSObject>

@property (nonatomic, weak) id<DismissViewProtocol> presenterDismiss;

@end

// Presenter -> Interactor
@protocol DismissPresenterInteractorProtocol <NSObject>

@property (nonatomic, weak) id<DismissInteractorProtocol> presenter;

@end

// Presenter -> Wireframe
@protocol DismissPresenterWireframeProtocol <NSObject>

@property (nonatomic, strong) id<DismissWireframeProtocol> presenter;

// should only use for adding dependencies
@property (nonatomic, strong) id<DismissPresenterInputProtocol> presenterInput;

-(void)shouldDismissVC;

@end
