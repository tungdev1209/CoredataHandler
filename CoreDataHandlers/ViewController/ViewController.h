//
//  ViewController.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootProtocols.h"

#import "FetchProtocols.h"
#import "AddProtocols.h"
#import "ShowProtocols.h"

@protocol ViewControllerProtocolInput <FetchPresenterViewProtocol, AddPresenterViewProtocol, ShowPresenterViewProtocol>
@end

@interface ViewController : UIViewController <RootViewProtocol, ViewControllerProtocolInput>

@end

