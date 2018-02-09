//
//  AddUserPresenter.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddUserProtocols.h"

@interface AddUserPresenter : NSObject <AddUserViewProtocol, AddUserWireframeProtocol, AddUserInteractorProtocol>

@property (nonatomic, weak) id<AddUserPresenterViewProtocol> view;
@property (nonatomic, weak) id<AddUserPresenterWireframeProtocol> wireframe;
@property (nonatomic, strong) id<AddUserPresenterInteractorProtocol> interactor;

@end
