//
//  ViewController.h
//  CoredataUpgrade
//
//  Created by Tung Nguyen on 2/8/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchUserProtocols.h"
#import "AddUserProtocols.h"
#import "RootProtocols.h"

@interface ViewController : UIViewController <RootViewProtocol, FetchUserPresenterViewProtocol, AddUserPresenterViewProtocol>

@property (nonatomic, strong) id<FetchUserViewProtocol> fetchUserPresenter;
@property (nonatomic, strong) id<AddUserViewProtocol> addUserPresenter;

@end

