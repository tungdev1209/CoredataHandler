//
//  ShowUserWireframe.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/9/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowUserProtocols.h"

@interface ShowUserWireframe : NSObject <ShowUserPresenterWireframeProtocol>

@property (nonatomic, strong) id<ShowUserWireframeProtocol> presenter;

@end
