//
//  FetchUserPresenter.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FetchUserProtocols.h"
#import "FetchUserInteractor.h"
#import "FetchUserWireframe.h"

@interface FetchUserPresenter : NSObject <FetchUserViewProtocol, FetchUserInteractorProtocol, FetchUserWireframeProtocol>

@property (nonatomic, strong) id<FetchUserPresenterInteractorProtocol> interactor;
@property (nonatomic, weak) id<FetchUserPresenterWireframeProtocol> wireframe;
@property (nonatomic, weak) id<FetchUserPresenterViewProtocol> view;

@end
