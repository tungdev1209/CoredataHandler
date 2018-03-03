//
//  ViewController.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootProtocols.h"
#import "AddProtocols.h"
#import "FetchProtocols.h"

@protocol ViewControllerProtocolInput <AddPresenterViewProtocol, FetchPresenterViewProtocol>
@end

@interface ViewController : UIViewController <RootViewProtocol, ViewControllerProtocolInput>

@end

