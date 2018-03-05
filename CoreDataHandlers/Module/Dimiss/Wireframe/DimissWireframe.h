//
//  DimissWireframe.h
//  CoreDataHandlers
//
//  Created by tungnguyen on 03/05/18.
//  Copyright © 2018 tungnguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DimissProtocols.h"

@interface DimissWireframe : NSObject <DimissPresenterWireframeProtocol>

@property (nonatomic, weak) UIViewController *viewController;

@end
