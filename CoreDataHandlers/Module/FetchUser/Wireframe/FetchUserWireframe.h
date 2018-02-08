//
//  FetchUserWireframe.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchUserProtocols.h"

@interface FetchUserWireframe : NSObject <FetchUserPresenterWireframeProtocol>

@property (nonatomic, weak) id<FetchUserWireframeProtocol> presenter;

@end
