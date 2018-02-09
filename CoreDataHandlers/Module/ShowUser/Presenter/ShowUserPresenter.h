//
//  ShowUserPresenter.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowUserProtocols.h"

@interface ShowUserPresenter : NSObject <ShowUserWireframeProtocol, ShowUserInteractorProtocol, ShowUserViewProtocol>

@property (nonatomic, strong) id<ShowUserPresenterInteractorProtocol> interactor;
@property (nonatomic, weak) id<ShowUserPresenterWireframeProtocol> wireframe;
@property (nonatomic, weak) id<ShowUserPresenterViewProtocol> view;

@end
