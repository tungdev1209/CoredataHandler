//
//  RootProtocols.h
//  CoreDataHandlers
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RootViewProtocol <NSObject>

-(void)startup:(NSArray *)dependencies;

@end

@protocol RootPresenterProtocol <NSObject>
@end

@protocol RootWireframeProtocol <NSObject>

@end
