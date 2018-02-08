//
//  RootPresenter.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RootProtocols.h"

@interface RootPresenter : NSObject <RootWireframeProtocol>

@property (nonatomic, strong) id<RootPresenterProtocol> wireframe;

+(instancetype)shared;
-(void)setup:(UIWindow *)window;

@end
