//
//  AddUserInteractor.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddUserProtocols.h"

@interface AddUserInteractor : NSObject <AddUserPresenterInteractorProtocol>

@property (nonatomic, weak) id<AddUserInteractorProtocol> presenter;

@end
