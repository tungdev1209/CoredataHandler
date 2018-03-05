//
//  DimissProtocols.h
//  CoreDataHandlers
//
//  Created by tungnguyen on 03/05/18.
//  Copyright © 2018 tungnguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DimissPresenterInteractorProtocol;
@protocol DimissPresenterViewProtocol;
@protocol DimissPresenterWireframeProtocol;

// View -> Presenter
@protocol DimissViewProtocol <NSObject>

@property (nonatomic, weak) id<DimissPresenterViewProtocol> view;

-(void)shouldDimissVC;

@end

// Interactor -> Presenter
@protocol DimissInteractorProtocol <NSObject>

@property (nonatomic, strong) id<DimissPresenterInteractorProtocol> interactor;

@end

// Wireframe -> Presenter
@protocol DimissWireframeProtocol <NSObject>

@property (nonatomic, weak) id<DimissPresenterWireframeProtocol> wireframe;

@end

// View, Interactor, Wireframe -> Presenter
@protocol DimissPresenterInputProtocol <DimissViewProtocol, DimissInteractorProtocol, DimissWireframeProtocol>
@end

// Presenter -> View
@protocol DimissPresenterViewProtocol <NSObject>

@property (nonatomic, weak) id<DimissViewProtocol> presenterDimiss;

@end

// Presenter -> Interactor
@protocol DimissPresenterInteractorProtocol <NSObject>

@property (nonatomic, weak) id<DimissInteractorProtocol> presenter;

@end

// Presenter -> Wireframe
@protocol DimissPresenterWireframeProtocol <NSObject>

@property (nonatomic, strong) id<DimissWireframeProtocol> presenter;

// should only use for adding dependencies
@property (nonatomic, strong) id<DimissPresenterInputProtocol> presenterInput;

-(void)shouldDismissVC;

@end
